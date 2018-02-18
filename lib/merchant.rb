require_relative 'statistics'

class Merchant
  attr_reader :id, :name
  attr_accessor :items

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @items = []
  end

  def average_item_price
    Statistics.new.mean(items.map(&:unit_price))
  end
end
