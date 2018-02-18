require_relative 'statistics'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @statistics = Statistics.new
  end

  def average_items_per_merchant
    statistics.mean(sales_engine.items_per_merchant.values).to_f.round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    sales_engine.find_merchant_by_id(merchant_id).average_item_price.round(2)
  end

  private
  attr_reader :sales_engine, :statistics
end
