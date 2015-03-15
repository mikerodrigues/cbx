class CBX
  class Feed
    API_URL = 'wss://ws-feed.exchange.coinbase.com'
    def initialize(on_message, on_close=nil, on_error=nil)
      subscription_request = { "type" => "subscribe", "product_id" => "BTC-USD" }
      ws = WebSocket::Client::Simple.connect API_URL
      @ws = ws
      ws.on :message do |event|
        msg = JSON.parse event.data
        on_message.call(msg) 
      end

      ws.on :open do
        ws.send subscription_request.to_json
      end

      ws.on :close do |e|
        if on_close
          on_close.call(e)
        end
        exit 1
      end

      ws.on :error do |e|
        if on_error
          on_error.call(e)
        end
      end
    end

    def close
      @ws.close
    end
  end
end
