module Skylight
  # @api private
  class Subscriber
    include Util::Logging

    attr_reader :config, :normalizers

    def initialize(config, instrumenter)
      @config = config
      @normalizers = Normalizers.build(config)
      @instrumenter = instrumenter
      @subscribers = []
    end

    def register!
      unregister!
      @normalizers.each_key { |key| @subscribers << ActiveSupport::Notifications.subscribe(key, self) }
    end

    def unregister!
      ActiveSupport::Notifications.unsubscribe @subscribers.shift until @subscribers.empty?
    end

    #
    #
    # ===== ActiveSupport::Notifications API
    #
    #

    class Notification
      attr_reader :name, :span

      def initialize(name, span)
        @name = name
        @span = span
      end
    end

    # cargo-culted from Rails's ConnectionAdapter
    EXCEPTION_NEVER = { Exception => :never }.freeze # :nodoc:
    EXCEPTION_IMMEDIATE = { Exception => :immediate }.freeze # :nodoc:
    private_constant :EXCEPTION_NEVER, :EXCEPTION_IMMEDIATE
    def with_trace(trace, &block) # :nodoc:
      Thread.handle_interrupt(EXCEPTION_NEVER) do
        previous_trace = @trace
        @trace = trace
        Thread.handle_interrupt(EXCEPTION_IMMEDIATE, &block)
      ensure
        @trace = previous_trace
      end
    end

    def start(name, _id, payload)
      return if @instrumenter.disabled?
      return unless (trace = current_trace)

      _start(trace, name, payload)
    end

    def finish(name, _id, payload)
      return if @instrumenter.disabled?
      return unless (trace = current_trace)

      while (curr = trace.notifications.pop)
        next unless curr.name == name

        meta = {}
        meta[:exception] = payload[:exception] if payload[:exception]
        meta[:exception_object] = payload[:exception_object] if payload[:exception_object]
        trace.done(curr.span, meta) if curr.span
        normalize_after(trace, curr.span, name, payload)
        return
      end
    rescue Exception => e
      error "Subscriber#finish error; msg=%s", e.message
      debug "trace=%s", trace.inspect
      debug "in:  name=%s", name.inspect
      debug "in:  payload=%s", payload.inspect
      t { e.backtrace.join("\n") }
      nil
    end

    def publish(name, *args)
      # Ignored for now because nothing in rails uses it
    end

    def publish_event(event)
      # Ignored for now because only ActiveRecord::FutureResult uses it and we handle that with probes
    end

    private

    def current_trace
      @trace || @instrumenter.current_trace
    end

    def normalize(*args)
      @normalizers.normalize(*args)
    end

    def normalize_after(*args)
      @normalizers.normalize_after(*args)
    end

    def _start(trace, name, payload)
      result = normalize(trace, name, payload)

      unless result == :skip
        case result.size
        when 3, 4
          cat, title, desc, meta = result
        else
          raise "Invalid normalizer result: #{result.inspect}"
        end

        span = trace.instrument(cat, title, desc, meta)
      end
    rescue Exception => e
      error "Subscriber#start error; msg=%s", e.message
      debug "trace=%s", trace.inspect
      debug "in:  name=%s", name.inspect
      debug "in:  payload=%s", payload.inspect
      debug "out: cat=%s, title=%s, desc=%s", cat.inspect, name.inspect, desc.inspect
      t { e.backtrace.join("\n") }
      nil
    ensure
      trace.notifications << Notification.new(name, span)
    end
  end
end
