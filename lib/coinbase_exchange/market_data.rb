class CoinbaseExchange
  module MarketData
    include ::CoinbaseExchange::Pagination

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
  end
end
