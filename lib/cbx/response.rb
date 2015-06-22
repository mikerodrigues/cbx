class CBX
  class Response
    attr_reader :body
    attr_reader :code
    attr_reader :cb_after
    attr_reader :cb_before

    def initialize(unirest_http_response)
      @body = unirest_http_response.body
      @code = unirest_http_response.code
      @cb_after = unirest_http_response.headers[:cb_after]
      @cb_before = unirest_http_response.headers[:cb_before]

      #case type
      #when 'accounts'
      #  @body.map! do |account|
      #    Account.new(account)
      #  end
      #when 'account'
      #  @body = Account.new(@body)
      #when 'ledger'
      #  @body.map! do |activity|
      #    Account
      #  end
      #when 'holds'
      #  @body
      #when 'orders'
      #  @body.map do |order|
      #    Order.new(order)
      #  end
    end
  end
end
