class CBX
  module Pagination
    private
    def paginate(hash)
      hash.keys.each.with_index.reduce("&") {|string, (key, index)| index > 0 ? string << "?" : ""; string << "#{key}=#{hash.fetch(key)}"}
    end
  end
end
