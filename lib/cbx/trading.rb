class CBX
  # Provides an interface to the Trading section of the Coinbase Exchange API.
  #
  module Trading
    include ::CBX::QueryParameters
    # Get a list of accounts 
    #
    def accounts(&block)
      get('accounts', nil, &block)
    end

    # Get an account by account_id
    #
    def account(account_id = nil, &block)
      get('accounts/' + account_id.to_s, nil, &block)
    end

    # Get account history by account_id (paginated)
    #
    def ledger(account_id, query_params = {}, &block)
      get('accounts/' + account_id.to_s + '/ledger' + linkify(query_params), nil, &block)
    end

    # Get account holds by account_id (paginated)
    def holds(account_id, query_params = {}, &block)
      get('accounts/' + account_id.to_s + '/holds' + linkify(query_params), nil, &block)
    end

    # Place a new order
    #
    def place_order(size: nil, price: nil, side: nil, product_id: nil, client_oid: nil, stp: nil, &block)
      order = { 
        'size' => size,
        'price' => price,
        'side' => side,
        'product_id' => product_id,
      }
      order['stp'] ||= stp
      order['client_oid'] ||= client_oid
      post('orders', order, &block)
    end
   
    # Cancel an order
    #
    def cancel_order(order_id, &block)
      delete('orders/' + order_id.to_s, nil, &block)
    end

    # List orders (query params: status), (paginated)
    #
    def orders(query_params = {}, &block)
      get('orders' + linkify(query_params), nil, &block)
    end

    # Get an order
    def order(order_id = nil, &block)
      get('orders/' + order_id.to_s, nil, &block)
    end

    # Deposit funds into your Exchange account from a Coinbase wallet.
    #
    def deposit(amount: nil, coinbase_account_id: nil, &block)
      order = { 
        'type' => 'deposit',
        'amount' => amount,
        'coinbase_account_id' => coinbase_account_id
      }
      post('transfers', order, &block)
    end

    # Withdraw funds to your Coinbase wallet.
    #
    def withdraw(amount: nil, coinbase_account_id: nil, &block)
      order = {
        'type' => 'withdraw',
        'amount' => amount,
        'coinbase_account_id' => coinbase_account_id
      }
      post('transfers', order, &block)
    end

    # List fills (query params: { order_id: all, product_id: all }), (paginated)
    #
    def fills(query_params = {}, &block)
      get('fills' + linkify(query_params), nil, &block)
    end

    # Create a report
    #
    def create_report(start_date: nil, end_date: nil, type: 'fill', &block)
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
