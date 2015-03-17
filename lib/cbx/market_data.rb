class CBX
  module MarketData
    include ::CBX::Pagination

    def products(&block)
      get('products', nil, &block)
    end

    def orderbook(level='1', product_id='BTC-USD', &block)
      get('products/' + product_id + '/book?level=' + String(level), nil, &block)
    end

    def ticker(product_id='BTC-USD', &block)
      get('products/' + product_id + '/ticker', nil, &block)
    end

    def trades(product_id='BTC-USD', &block)
      get('products/' + product_id + '/trades', nil, &block)
    end

    def candles(level='1', product_id='BTC-USD', &block)
      get('products/' + product_id + '/candles', nil, &block)
    end

    def stats(&block)
      get('products/' + product_id + '/states', nil, &block)
    end

    def currencies(&block)
      get('currencies', nil, &block)
    end

    def time(&block)
      get('time', nil, &block)
    end
  end
end
