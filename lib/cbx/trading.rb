class CBX
  module Trading
    include ::CBX::Pagination
    
    # Account methods
    #
    def accounts(account_id=nil, &block)
      if account_id.nil? then
        get('accounts', nil, &block)
      else
        get('accounts/' + account_id.to_s, nil, &block)
      end
    end

    def ledger(account_id, pagination = {}, &block)
      get('accounts/' + account_id.to_s + '/ledger' + paginate(pagination), nil, &block)
    end

    def holds(account_id, pagination = {}, &block)
      get('accounts/' + account_id.to_s + '/holds' + paginate(pagination), nil, &block)
    end

    # Order methods
    #
    def orders(pagination = {}, &block)
      get('orders' + paginate(pagination), nil, &block)
    end

    def order(order_id=nil, &block)
      if order_id.nil? then
        get('orders', nil, &block)
      else
        get('orders/' + order_id.to_s, nil, &block)
      end
    end

    def cancel_order(order_id, &block)
      delete('orders/' + order_id.to_s, nil, &block)
    end

    def place_order(size, price, side, product_id='BTC-USD', &block)
      order = { 'size' => size, 'price' => price, 'side' => side, 'product_id' => product_id}
      post('orders', order, &block)
    end

    # Transfer funds methods
    #
    def deposit(amount, coinbase_account_id, &block)
      order = { 'type' => 'deposit', 'amount' => amount, 'coinbase_account_id' => coinbase_account_id }
      post('orders', order, &block)
    end

    def withdraw(amount, coinbase_account_id, &block)
      order = { 'type' => 'withdraw', 'amount' => amount, 'coinbase_account_id' => coinbase_account_id }
      post('orders', order, &block)
    end

    # Fill methods
    #
    def fills(pagination = {}, &block)
      get('fills' + paginate(pagination), nil, &block)
    end
  end
end
