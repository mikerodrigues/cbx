class CBX
  # Provides an interface to the Market Data section of the Coinbase Exchange
  # API.
  #
  module MarketData
    include ::CBX::Pagination

    def products(&block)
      get('products', nil, &block)
    end

    def book(params = {}, product_id = 'BTC-USD', &block)
      get('products/' + product_id + '/book' + paginate(params), nil, &block)
    end

    def ticker(product_id = 'BTC-USD', &block)
      get('products/' + product_id + '/ticker', nil, &block)
    end

    def trades(params = {}, product_id = 'BTC-USD', &block)
      get('products/' + product_id + '/trades' + paginate(params), nil, &block)
    end

    def candles(params = {}, product_id = 'BTC-USD', &block)
      get('products/' + product_id + '/candles' + paginate(params), nil, &block)
    end

    def stats( product_id = 'BTC-USD', &block)
      get('products/' + product_id + '/stats', nil, &block)
    end

    def currencies(&block)
      get('currencies', nil, &block)
    end

    def time(&block)
      get('time', nil, &block)
    end
  end
end
