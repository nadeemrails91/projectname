require 'spec_helper'

describe "WebMock" do

  describe ".version" do
    it "should report version" do
      expect(WebMock.version).to eq(WebMock::VERSION)
    end

    it "should not require safe_yaml" do
      expect(defined?SafeYAML).to eq(nil)
    end

    it "should alias enable_net_connect! to allow_net_connect!" do
      expect(WebMock.method(:enable_net_connect!)).to eq(WebMock.method(:allow_net_connect!))
    end

    it "should alias disallow_net_connect! to disable_net_connect!" do
      expect(WebMock.method(:disallow_net_connect!)).to eq(WebMock.method(:disable_net_connect!))
    end
  end

  describe ".net_connect_allowed?" do
    context 'enabled globally' do
      before do
        WebMock.enable_net_connect!
      end

      context 'without arguments' do
        it 'returns WebMock::Config.instance.allow_net_connect' do
          expect(WebMock.net_connect_allowed?).to eql(true)
        end
      end
    end

    context 'disabled with allowed remote string' do
      before do
        WebMock.disable_net_connect!(allow: "http://192.168.64.2:20031")
      end

      context 'without arguments' do
        it 'returns WebMock::Config.instance.allow_net_connect' do
          expect(WebMock.net_connect_allowed?).to eql(false)
        end
      end
    end

    context 'disabled globally' do
      before do
        WebMock.disable_net_connect!
      end

      context 'without arguments' do
        it 'returns WebMock::Config.instance.allow_net_connect' do
          expect(WebMock.net_connect_allowed?).to eql(false)
        end
      end
    end
  end

  describe ".net_http_connect_on_start?" do
    let(:uri) { Addressable::URI.parse("http://example.org:5432") }

    it "will not connect on start when false" do
      WebMock.disable_net_connect!
      expect(WebMock.net_http_connect_on_start?(uri)).to be(false)
    end

    it "will connect on start when true" do
      WebMock.disable_net_connect!(net_http_connect_on_start: true)
      expect(WebMock.net_http_connect_on_start?(uri)).to be(true)
    end

    it "will connect on start when regexp matches" do
      WebMock.disable_net_connect!(net_http_connect_on_start: /example/)
      expect(WebMock.net_http_connect_on_start?(uri)).to be(true)
    end

    it "will not connect on start when regexp does not match" do
      WebMock.disable_net_connect!(net_http_connect_on_start: /nope/)
      expect(WebMock.net_http_connect_on_start?(uri)).to be(false)
    end

    it "will connect on start when host matches" do
      WebMock.disable_net_connect!(net_http_connect_on_start: "example.org")
      expect(WebMock.net_http_connect_on_start?(uri)).to be(true)
    end

    it "will not connect on start when host does not match" do
      WebMock.disable_net_connect!(net_http_connect_on_start: "localhost")
      expect(WebMock.net_http_connect_on_start?(uri)).to be(false)
    end

    it "will connect on start when host + port matches" do
      WebMock.disable_net_connect!(net_http_connect_on_start: "example.org:5432")
      expect(WebMock.net_http_connect_on_start?(uri)).to be(true)
    end

    it "will not connect on start when host + port does not match" do
      WebMock.disable_net_connect!(net_http_connect_on_start: "example.org:80")
      expect(WebMock.net_http_connect_on_start?(uri)).to be(false)
    end

    it "will connect on start when scheme + host + port matches" do
      WebMock.disable_net_connect!(net_http_connect_on_start: "http://example.org:5432")
      expect(WebMock.net_http_connect_on_start?(uri)).to be(true)
    end

    it "will not connect on start when scheme + host + port does not match" do
      WebMock.disable_net_connect!(net_http_connect_on_start: "https://example.org:5432")
      expect(WebMock.net_http_connect_on_start?(uri)).to be(false)
    end
  end
end
