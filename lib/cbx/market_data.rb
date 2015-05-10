class CBX
  # Provides an interface to the Market Data section of the Coinbase Exchange
  # API.
  #
  module MarketData
    include ::CBX::QueryParameters

    def products(product_id = nil, &block)
      if product_id
        get('products/' + product_id, nil, &block)
      else
        get('products', nil, &block)
      end
    end

    def book(params = {}, product_id = CBX::DEFAULT_PRODUCT_ID, &block)
      get('products/' + product_id + '/book' + linkify(params), nil, &block)
    end

    def ticker(product_id = CBX::DEFAULT_PRODUCT_ID, &block)
      get('products/' + product_id + '/ticker', nil, &block)
    end

    def trades(params = {}, product_id = CBX::DEFAULT_PRODUCT_ID, &block)
      get('products/' + product_id + '/trades' + linkify(params), nil, &block)
    end

    def candles(params = {}, product_id = CBX::DEFAULT_PRODUCT_ID, &block)
      get('products/' + product_id + '/candles' + linkify(params), nil, &block)
    end

    def stats(product_id = CBX::DEFAULT_PRODUCT_ID, &block)
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
