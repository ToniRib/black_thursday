require 'spec_helper'
require './lib/sales_engine'

describe SalesEngine do
  describe '.from_csv' do
    let(:csv_files) do
      {
        items: './spec/data/items.csv',
        merchants: './spec/data/merchants.csv',
      }
    end

    subject { described_class.from_csv(csv_files) }

    it 'creates a new SalesEngine instance' do
      expect(subject).to be_an_instance_of(SalesEngine)
    end

    it 'loads the associated merchant repository with Merchants from the file' do
      expect(subject.merchants.class).to eq MerchantRepository
      expect(subject.merchants.all.length).to eq 3
      expect(subject.merchants.all.first.class).to eq Merchant
    end

    it 'loads the associated item repository with Items from the file' do
      expect(subject.items.class).to eq ItemRepository
      expect(subject.items.all.length).to eq 3
      expect(subject.items.all.first.class).to eq Item
    end

    describe 'associations' do
      it 'create association between merchant and items' do
        expect(subject.merchants.all.first.items.length).to eq 2
      end

      it 'create association between items and merchant' do
        expect(subject.items.all.first.merchant.name).to eq 'Shopin1901'
      end
    end
  end
end
