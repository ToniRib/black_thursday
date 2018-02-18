require 'spec_helper'
require './lib/item'
require './lib/merchant'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/sales_analyst'

describe SalesAnalyst do
  let(:merchants) do
    [
      Merchant.new(id: 1, name: 'American Eagle'),
      Merchant.new(id: 2, name: 'ModCloth'),
      Merchant.new(id: 3, name: 'Etsy'),
    ]
  end
  let(:items) do
    [
      Item.new(id: 1, name: 'Sweater', unit_price: BigDecimal.new(10.00, 4))
        .tap { |item| item.merchant_id = merchants[0].id },
      Item.new(id: 2, name: 'Jeans', unit_price: BigDecimal.new(20.00, 4))
        .tap { |item| item.merchant_id = merchants[1].id },
      Item.new(id: 3, name: 'Skirt', unit_price: BigDecimal.new(30.00, 4))
        .tap { |item| item.merchant_id = merchants[1].id },
      Item.new(id: 4, name: 'Dress', unit_price: BigDecimal.new(10.00, 4))
        .tap { |item| item.merchant_id = merchants[2].id },
      Item.new(id: 5, name: 'Coat', unit_price: BigDecimal.new(40.00, 4))
        .tap { |item| item.merchant_id = merchants[2].id },
      Item.new(id: 6, name: 'Scarf', unit_price: BigDecimal.new(100.00, 4))
        .tap { |item| item.merchant_id = merchants[2].id },
      Item.new(id: 7, name: 'Necklace', unit_price: BigDecimal.new(80.00, 4))
        .tap { |item| item.merchant_id = merchants[2].id },
    ]
  end
  let(:merchant_repo) { MerchantRepository.new(merchants) }
  let(:item_repo) { ItemRepository.new(items) }
  let(:sales_engine) { SalesEngine.new(merchant_repo: merchant_repo, item_repo: item_repo) }

  before { Relationships.new.build!(merchant_repo, item_repo) }

  subject { described_class.new(sales_engine) }

  describe '#average_items_per_merchant' do
    it 'returns average number of items per merchant' do
      expect(subject.average_items_per_merchant).to eq 2.33
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns average price of item for given merchant' do
      expect(subject.average_item_price_for_merchant(merchants[2].id)).to eq 57.5
    end
  end
end
