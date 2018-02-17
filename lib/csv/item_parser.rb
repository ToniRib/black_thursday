require './lib/item'
require 'csv'

module Csv
  class ItemParser
    def self.parse(filename)
      CSV.open(filename, { headers: true, header_converters: :symbol }).map do |row|
        Item.new({
          name: row[:name],
          description: row[:description],
          unit_price: BigDecimal.new(row[:unit_price].to_i, 4),
          created_at: DateTime.parse(row[:created_at]),
          updated_at: DateTime.parse(row[:updated_at]),
        }).tap do |item|
          item.merchant_id = row[:merchant_id].to_i
        end
      end
    end
  end
end
