class CBX
  # Provides an interface to the Coinbase Exchange WebSocket feed.
  #
  class Feed
    API_URL = 'wss://ws-feed.exchange.coinbase.com'
    SANDBOX_API_URL = 'wss://ws-feed-public.sandbox.exchange.coinbase.com'
    SUBSCRIPTION_REQUEST = { 'type' => 'subscribe', 'product_id' => CBX::DEFAULT_PRODUCT_ID }
    def initialize(on_message, on_close = nil, on_error = nil)
      ws = WebSocket::Client::Simple.connect API_URL
      @ws = ws
      ws.on :message do |event|
        msg = JSON.parse event.data
        on_message.call(msg)
      end

      ws.on :open do
        ws.send SUBSCRIPTION_REQUEST.to_json
      end

      ws.on :close do |e|
        on_close && on_close.call(e)
        exit 1
      end

      ws.on :error do |e|
        on_error && on_error.call(e)
      end
    end

    def close
      @ws.close
    end
  end
end
