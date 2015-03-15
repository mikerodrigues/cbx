class CBX
  module Pagination
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
