require 'spec_helper'
require './lib/relationships'
require './lib/merchant'
require './lib/item'
require './lib/merchant_repository'
require './lib/item_repository'

describe Relationships do
  let(:merchants) { [Merchant.new(id: 1, name: 'Etsy')] }
  let(:items) do
    [
      Item.new(
        id: 1,
        name: 'Apple',
      ).tap { |item| item.merchant_id = 1 },
      Item.new(
        id: 2,
        name: 'Banana',
      ).tap { |item| item.merchant_id = 1 },
    ]
  end
  let(:merchant_repo) { MerchantRepository.new(merchants) }
  let(:item_repo) { ItemRepository.new(items) }

  describe '#build!' do
    it 'create association between merchant and items' do
      subject.build!(merchant_repo, item_repo)

      expect(merchants.first.items).to match_array items
    end

    it 'create association between items and merchant' do
      subject.build!(merchant_repo, item_repo)

      expect(items.first.merchant).to eq merchants.first
      expect(items.last.merchant).to eq merchants.first
    end
  end
end
