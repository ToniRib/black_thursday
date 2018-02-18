require 'spec_helper'
require './lib/merchant'
require './lib/item'

describe Merchant do
  subject { described_class.new({ id: 1, name: 'Etsy' }) }

  it 'has a name' do
    expect(subject.name).to eq 'Etsy'
  end

  it 'has an id' do
    expect(subject.id).to eq 1
  end

  describe 'adding items' do
    it 'has no items by default' do
      expect(subject.items).to be_empty
    end

    it 'can have items added to it' do
      scarf = Item.new({ id: 1, name: 'scarf' })
      bandana = Item.new({ id: 2, name: 'bandana' })

      subject.items = [scarf, bandana]

      expect(subject.items).to contain_exactly scarf, bandana
    end
  end

  describe '#average_item_price' do
    before do
      scarf = Item.new({ id: 1, unit_price: BigDecimal.new(10.00, 4) })
      bandana = Item.new({ id: 2, unit_price: BigDecimal.new(12.00, 4) })

      subject.items = [scarf, bandana]
    end

    it 'returns the average price of associated items' do
      expect(subject.average_item_price).to eq BigDecimal(11.00, 4)
    end
  end
end
