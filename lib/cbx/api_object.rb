class CBX
  class APIObject < Hash
    def initialize(response)
      response.each do |k, v|
        self[k] = v
      end
    end

    def []=(k, v)
      unless respond_to?(k)
        self.class.send( :define_method, k ) do
          self[k]
        end
      end

      super
    end
  end
end
