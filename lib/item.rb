require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at
  attr_accessor :merchant_id, :merchant

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end
end
