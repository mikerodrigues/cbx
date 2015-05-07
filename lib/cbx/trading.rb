class CBX
  # Provides an interface to the Trading section of the Coinbase Exchange API.
  #
  module Trading
    include ::CBX::Pagination
    # Account methods
    #
    def accounts(account_id = nil, &block)
      if account_id.nil?
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

    def order(order_id = nil, &block)
      if order_id.nil?
        get('orders', nil, &block)
      else
        get('orders/' + order_id.to_s, nil, &block)
      end
    end

    def cancel_order(order_id, &block)
      delete('orders/' + order_id.to_s, nil, &block)
    end

    def place_order(size, price, side, product_id = CBX::DEFAULT_PRODUCT_ID, &block)
      order = { 
        'size' => size,
        'price' => price,
        'side' => side,
        'product_id' => product_id
      }
      post('orders', order, &block)
    end

    # Deposit funds into your Exchange account from a Coinbase wallet.
    #
    def deposit(amount, coinbase_account_id, &block)
      order = { 
        'type' => 'deposit',
        'amount' => amount,
        'coinbase_account_id' => coinbase_account_id
      }
      post('orders', order, &block)
    end

    # Withdraw funds to your Coinbase wallet.
    #
    def withdraw(amount, coinbase_account_id, &block)
      order = {
        'type' => 'withdraw',
        'amount' => amount,
        'coinbase_account_id' => coinbase_account_id
      }
      post('orders', order, &block)
    end

    # Fill methods
    #
    def fills(pagination = {}, &block)
      get('fills' + paginate(pagination), nil, &block)
    end

    # Create a report
    #
    def create_report(start_date = nil, end_date = nil, type = 'fill' &block)
      params = {
        'type' => type,
        'start_date' => start_date,
        'end_date' => end_date
      }
      post('reports', params, &block)
    end

    # Get info about a report
    #
    def report_info(report_id, &block)
      get('reports/' + report_id, &block)
    end
  end
end
