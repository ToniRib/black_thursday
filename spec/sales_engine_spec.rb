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

    it 'creates a new SalesEngine instance' do
      expect(described_class.from_csv(csv_files)).to be_an_instance_of(SalesEngine)
    end

    it 'loads the associated merchant repository with Merchants from the file' do
      sales_engine = described_class.from_csv(csv_files)

      expect(sales_engine.merchants.class).to eq MerchantRepository
      expect(sales_engine.merchants.all.length).to eq 3
      expect(sales_engine.merchants.all.first.class).to eq Merchant
    end

    it 'loads the associated item repository with Items from the file' do
      sales_engine = described_class.from_csv(csv_files)

      expect(sales_engine.items.class).to eq ItemRepository
      expect(sales_engine.items.all.length).to eq 3
      expect(sales_engine.items.all.first.class).to eq Item
    end
  end
end
