require 'spec_helper'
require './lib/merchant_repository'
require './lib/merchant'

describe MerchantRepository do
  let(:merchants) do
    [
      Merchant.new(id: 1, name: 'Etsy'),
      Merchant.new(id: 2, name: 'Target'),
    ]
  end

  subject { described_class.new(merchants) }

  describe '#all' do
    it 'returns an array of Merchants' do
      expect(subject.all.map(&:class).uniq).to eq [Merchant]
    end
  end

  describe '#find_by_id' do
    context 'when Merchant is found' do
      it 'returns the correct Merchant' do
        expect(subject.find_by_id(1)).to eq merchants[0]
      end
    end

    context 'when Merchant cannot be found' do
      it 'returns nil' do
        expect(subject.find_by_id(1000)).to be_nil
      end
    end
  end

  describe '#find_by_name' do
    context 'when exact Merchant name is found' do
      it 'returns the correct Merchant' do
        expect(subject.find_by_name('Target')).to eq merchants[1]
      end
    end

    context 'when case insensitive match of name is found' do
      it 'returns the correct Merchant' do
        expect(subject.find_by_name('tARget')).to eq merchants[1]
      end
    end

    context 'when Merchant cannot be found' do
      it 'returns nil' do
        expect(subject.find_by_name('Sports Authority')).to be_nil
      end
    end
  end

  describe '#find_all_by_name' do
    let(:merchants) do
      [
        Merchant.new(id: 1, name: 'Etsy'),
        Merchant.new(id: 2, name: 'Target'),
        Merchant.new(id: 3, name: 'Super Target'),
      ]
    end

    context 'when merchant names match any part' do
      it 'returns the correct Merchants' do
        expect(subject.find_all_by_name('Target')).to match_array [merchants[1], merchants[2]]
      end
    end

    context 'when name matches case insensitively' do
      it 'returns the correct Merchants' do
        expect(subject.find_all_by_name('tarGET')).to match_array [merchants[1], merchants[2]]
      end
    end

    context 'when no names match' do
      it 'an empty array' do
        expect(subject.find_all_by_name('bananas')).to be_empty
      end
    end
  end
end
