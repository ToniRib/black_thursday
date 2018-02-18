class ItemRepository
  def initialize(items)
    @items = items
  end

  def all
    items
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    items.select { |item| item.description.downcase.include?(description.downcase) }
  end

  def find_all_by_price(price)
    items.select { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    items.select { |item| range.cover?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    items.select { |item| item.merchant_id == merchant_id }
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end

  private
  attr_reader :items
end
