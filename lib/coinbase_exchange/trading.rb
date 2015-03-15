class CoinbaseExchange
  module Trading
    # Account methods
    #
    def accounts(account_id=nil)
      if account_id.nil? then
        get('accounts')
      else
        get('accounts/' + account_id.to_s)
      end
    end

    def ledger(account_id, pagination = {})
      get('accounts/' + account_id.to_s + '/ledger' + paginate(pagination))
    end

    def holds(account_id, pagination = {})
      get('accounts/' + account_id.to_s + '/holds' + paginate(pagination))
    end

    # Order methods
    #
    def orders(pagination = {})
      get('orders' + paginate(pagination))
    end

    def order(order_id=nil)
      if order_id.nil? then
        get('orders')
      else
        get('orders/' + order_id.to_s)
      end
    end

    def cancel_order(order_id)
      delete('orders/' + order_id.to_s)
    end

    def place_order(size, price, side, product_id='BTC-USD')
      order = { 'size' => size, 'price' => price, 'side' => side, 'product_id' => product_id}
      post('orders', order)
    end

    # Transfer funds methods
    #
    def deposit(amount, coinbase_account_id)
      order = { 'type' => 'deposit', 'amount' => amount, 'coinbase_account_id' => coinbase_account_id }
      post('orders', order)
    end

    def withdraw(amount, coinbase_account_id)
      order = { 'type' => 'withdraw', 'amount' => amount, 'coinbase_account_id' => coinbase_account_id }
      post('orders', order)
    end

    # Fill methods
    #
    def fills(pagination = {})
      get('fills' + paginate(pagination))
    end

    private

    def paginate(hash)
      string = ""
      hash.keys.each do |key|
        string << "&#{key}=#{hash.fetch(key)}"
      end
      return string.sub(/^&/, '?')
    end
  end
end
