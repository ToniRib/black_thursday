require_relative '../item'
require 'csv'
require 'time'

module Csv
  class ItemParser
    def self.parse(filename)
      CSV.open(filename, { headers: true, header_converters: :symbol }).map do |row|
        Item.new({
          id: row[:id].to_i,
          name: row[:name],
          description: row[:description],
          unit_price: BigDecimal.new(row[:unit_price].to_i, 4) / 100,
          created_at: Time.parse(row[:created_at]),
          updated_at: Time.parse(row[:updated_at]),
        }).tap do |item|
          item.merchant_id = row[:merchant_id].to_i
        end
      end
    end
  end
end
