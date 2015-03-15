class CoinbaseExchange
  module MarketData

    def products
      get('products')
    end

    def orderbook(level='1', product_id='BTC-USD')
      get('products/' + product_id + '/book?level=' + String(level))
    end

    def ticker(product_id='BTC-USD')
      get('products/' + product_id + '/ticker')
    end

    def trades(product_id='BTC-USD')
      get('products/' + product_id + '/trades')
    end

  end
end
