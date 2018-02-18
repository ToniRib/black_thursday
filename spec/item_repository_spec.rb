require 'spec_helper'
require './lib/item_repository'
require './lib/item'
require 'bigdecimal'

describe ItemRepository do
  let(:items) do
    [
      Item.new(
        id: 1,
        name: 'Apple',
        description: 'A nice red fruit',
        unit_price: BigDecimal.new(100, 4),
      ).tap { |item| item.merchant_id = 20 },
      Item.new(
        id: 2,
        name: 'Banana',
        description: 'A delicious yellow fruit',
        unit_price: BigDecimal.new(200, 4),
      ).tap { |item| item.merchant_id = 20 },
      Item.new(
        id: 3,
        name: 'Cauliflower',
        description: 'A really good vegetable',
        unit_price: BigDecimal.new(100, 4),
      ).tap { |item| item.merchant_id = 30 },
    ]
  end

  subject { described_class.new(items) }

  describe '#all' do
    it 'returns an array of Items' do
      expect(subject.all.map(&:class).uniq).to eq [Item]
    end
  end

  describe '#find_by_id' do
    context 'when Item is found' do
      it 'returns the correct Item' do
        expect(subject.find_by_id(1)).to eq items[0]
      end
    end

    context 'when Item cannot be found' do
      it 'returns nil' do
        expect(subject.find_by_id(1000)).to be_nil
      end
    end
  end

  describe '#find_by_name' do
    context 'when exact Item name is found' do
      it 'returns the correct Item' do
        expect(subject.find_by_name('Banana')).to eq items[1]
      end
    end

    context 'when case insensitive match of name is found' do
      it 'returns the correct Item' do
        expect(subject.find_by_name('baNANA')).to eq items[1]
      end
    end

    context 'when Item cannot be found' do
      it 'returns nil' do
        expect(subject.find_by_name('Pear')).to be_nil
      end
    end
  end

  describe '#find_all_with_description' do
    context 'when item descriptions match any part' do
      it 'returns the correct Items' do
        expect(subject.find_all_with_description('fruit')).to match_array [items[0], items[1]]
      end
    end

    context 'when description matches case insensitively' do
      it 'returns the correct Items' do
        expect(subject.find_all_with_description('FRUIT')).to match_array [items[0], items[1]]
      end
    end

    context 'when no descriptions match' do
      it 'returns an empty array' do
        expect(subject.find_all_with_description('meat')).to be_empty
      end
    end
  end

  describe '#find_all_by_price' do
    context 'when prices matches exactly' do
      it 'returns the correct Items' do
        expect(subject.find_all_by_price(BigDecimal.new(100, 4))).to match_array [items[0], items[2]]
      end
    end

    context 'when price does not match' do
      it 'returns an empty array' do
        expect(subject.find_all_by_price(BigDecimal.new(500, 4))).to be_empty
      end
    end
  end

  describe '#find_all_by_price_in_range' do
    context 'when items within range' do
      let(:range) { BigDecimal.new(50, 4)..BigDecimal.new(150, 4) }

      it 'returns the correct Items' do
        expect(subject.find_all_by_price_in_range(range)).to match_array [items[0], items[2]]
      end
    end

    context 'when no items within range' do
      let(:range) { BigDecimal.new(0, 4)..BigDecimal.new(10, 4) }

      it 'returns an empty array' do
        expect(subject.find_all_by_price_in_range(range)).to be_empty
      end
    end
  end

  describe '#find_all_by_merchant_id' do
    context 'when items match merchant_id' do
      it 'returns the correct Items' do
        expect(subject.find_all_by_merchant_id(20)).to match_array [items[0], items[1]]
      end
    end

    context 'when no items match merchant_id' do
      it 'returns an empty array' do
        expect(subject.find_all_by_merchant_id(50)).to be_empty
      end
    end
  end
end
