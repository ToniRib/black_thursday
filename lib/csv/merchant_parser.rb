require './lib/merchant'
require 'csv'

module Csv
  class MerchantParser
    def self.parse(filename)
      CSV.open(filename, { headers: true, header_converters: :symbol }).map do |row|
        Merchant.new({ id: row[:id].to_i, name: row[:name] })
      end
    end
  end
end
