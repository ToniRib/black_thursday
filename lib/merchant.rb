class Merchant
  attr_reader :id, :name
  attr_accessor :items

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @items = []
  end
end
