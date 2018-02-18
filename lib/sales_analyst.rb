class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    mean(sales_engine.items_per_merchant.values)
  end

  private
  attr_reader :sales_engine

  def sum(numbers)
    numbers.inject(0.0) { |result, number| result + number }
  end

  def mean(numbers)
    (sum(numbers).to_f / numbers.size).round(2)
  end
end
