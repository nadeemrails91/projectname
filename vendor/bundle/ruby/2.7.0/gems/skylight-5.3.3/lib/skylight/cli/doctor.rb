require "skylight/util/http"

module Skylight
  module CLI
    class Doctor < Thor::Group
      include Helpers

      desc "Run some basic tests to look out for common errors"

      def check_ssl
        say "Checking SSL"
        http = Util::HTTP.new(config)
        indent do
          req = http.get("/status")
          if req.success?
            say "OK", :green
          else
            encountered_error!
            if req.exception.is_a?(Util::HTTP::StartError) && req.exception.original.is_a?(OpenSSL::SSL::SSLError)
              say "Failed to verify SSL certificate.", :red
              if Util::SSL.ca_cert_file?
                say "Certificates located at #{Util::SSL.ca_cert_file_or_default} may be out of date.", :yellow
                if mac? && rvm_present?
                  say "Please update your certificates with RVM by running `rvm osx-ssl-certs update all`.", :yellow
                  say "Alternatively, try setting `SKYLIGHT_FORCE_OWN_CERTS=1` in your environment.", :yellow
                else
                  say "Please update your local certificates or try setting `SKYLIGHT_FORCE_OWN_CERTS=1` in your " \
                        "environment.",
                      :yellow
                end
              end
            else
              say "Unable to reach Skylight servers.", :red
            end
          end
        end
        say "\n"
      end

      def check_rails
        say "Checking for Rails"

        indent do
          if rails?
            say "Rails application detected", :green
          else
            say "No Rails application detected", :yellow
            say "Additional `skylight doctor` checks only work with Rails applications.", :yellow
            done!
          end
        end

        say "\n"
      end

      def check_native
        say "Checking for native agent"

        indent do
          if Skylight.native?
            say "Native agent installed", :green
          else
            encountered_error!

            say "Unable to load native extension", :yellow

            indent do
              install_log = File.expand_path("../../../ext/install.log", __dir__)
              if File.exist?(install_log)
                File.readlines(install_log).each { |line| say line, :red }
              else
                say "Reason unknown", :red
              end
            end

            done!
          end
        end

        say "\n"
      end

      def check_config
        say "Checking for valid configuration"

        indent do
          config.validate!
          say "Configuration is valid", :green
        rescue ConfigError => e
          encountered_error!

          say "Configuration is invalid", :red
          indent do
            say e.message, :red
            say "This may occur if you are configuring with ENV variables and didn't set them in this shell."
          end

          done!
        end

        puts "\n"
      end

      def check_daemon
        say "Checking Skylight startup"

        indent do
          # Set this after we validate. It will give us more detailed information on start.
          logger = Logger.new("/dev/null") # Rely on `say` in the formatter instead

          # Log everything
          logger.level = Logger::DEBUG

          # Remove excess formatting
          logger.formatter =
            proc do |severity, _datetime, _progname, msg|
              msg = msg.sub("[SKYLIGHT] [#{Skylight::VERSION}] ", "")
              say "#{severity} - #{msg}" # Definitely non-standard
            end
          config.logger = logger

          config.set(:"daemon.lazy_start", false)

          started = Skylight.start!(config)

          if started
            say "Successfully started", :green
          else
            encountered_error!

            say "Failed to start", :red

            done!
          end

          say "Waiting for daemon... "

          # Doesn't start immediately
          tries = 0
          daemon_running = false
          while tries < 5
            `ps cax | grep skylightd`
            if $CHILD_STATUS.success?
              daemon_running = true
              break
            end

            tries += 1
            sleep 1
          end

          if daemon_running
            say "Success", :green
          else
            encountered_error!

            say "Failed", :red
          end
        end

        say "\n"
      end

      def wrap_up
        done!
      end

      private

      # Overwrite the default helper method to load from Rails
      def config
        return @config if @config

        # MEGAHAX
        if rails?
          # Normally auto-loaded, but we haven't loaded Rails by the time Skylight is loaded
          require "skylight/railtie"
          require rails_rb

          railtie = Skylight::Railtie.send(:new)
          @config = railtie.send(:load_skylight_config, Rails.application)
        else
          super
        end
      end

      def mac?
        Util::Platform::OS == "darwin"
      end

      # NOTE: This check won't work correctly on Windows
      def rvm_present?
        @has_rvm = system("which rvm > /dev/null") if @has_rvm.nil?
        @has_rvm
      end

      def encountered_error!
        @has_errors = true
      end

      def has_errors?
        @has_errors
      end

      def done!
        shell.padding = 0
        say "\n\n"

        if has_errors?
          say "Skylight Doctor found some errors. Please review the output above.", :red
          say "If you have any further questions, please contact support@skylight.io.", :yellow
          exit 1
        else
          say "All checks passed!", :green
          say "If you're still having trouble, please contact support@skylight.io.", :yellow
          exit 0
        end
      end
    end
  end
end
