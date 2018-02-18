class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    item_counts = sales_engine.merchants.all.map do |merchant|
      merchant.items.count
    end

    mean(item_counts)
  end

  private
  attr_reader :sales_engine

  def sum(numbers)
    numbers.inject(0.0) { |result, el| result + el }
  end

  def mean(numbers)
    (sum(numbers).to_f / numbers.size).round(2)
  end
end
