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
      Item.new(id: 1, name: 'Sweater').tap { |item| item.merchant_id = merchants[0].id },
      Item.new(id: 2, name: 'Jeans').tap { |item| item.merchant_id = merchants[1].id },
      Item.new(id: 3, name: 'Skirt').tap { |item| item.merchant_id = merchants[1].id },
      Item.new(id: 4, name: 'Dress').tap { |item| item.merchant_id = merchants[2].id },
      Item.new(id: 5, name: 'Coat').tap { |item| item.merchant_id = merchants[2].id },
      Item.new(id: 6, name: 'Scarf').tap { |item| item.merchant_id = merchants[2].id },
      Item.new(id: 7, name: 'Necklace').tap { |item| item.merchant_id = merchants[2].id },
    ]
  end
  let(:sales_engine) do
    SalesEngine.new(
      merchant_repo: MerchantRepository.new(merchants),
      item_repo: ItemRepository.new(items),
    )
  end

  subject { described_class.new(sales_engine) }

  describe '#average_items_per_merchant' do
    it 'returns average number of items per merchant' do
      expect(subject.average_items_per_merchant).to eq 2.33
    end
  end
end
