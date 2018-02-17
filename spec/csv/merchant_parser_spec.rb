require 'spec_helper'
require './lib/csv/merchant_parser'

module Csv
  describe MerchantParser do
    let(:filename) { './spec/data/merchants.csv' }

    it 'creates a Merchant for each non-header line' do
      merchants = described_class.parse(filename)

      expect(merchants.length).to eq 3
    end

    it 'creates the correct Merchants' do
      merchants = described_class.parse(filename)

      expect(merchants[0].id).to eq 12334105
      expect(merchants[0].name).to eq 'Shopin1901'
      expect(merchants[1].id).to eq 12334112
      expect(merchants[1].name).to eq 'Candisart'
      expect(merchants[2].id).to eq 12334113
      expect(merchants[2].name).to eq 'MiniatureBikez'
    end
  end
end
