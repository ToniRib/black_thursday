require 'spec_helper'
require './lib/csv/item_parser'

module Csv
  describe ItemParser do
    let(:filename) { './spec/data/items.csv' }

    describe '.parse' do
      it 'creates an Item for each non-header line' do
        items = described_class.parse(filename)

        expect(items.length).to eq 3
      end

      it 'creates the correct Items' do
        items = described_class.parse(filename)

        expect(items[0].id).to eq 263397201
        expect(items[0].name).to eq 'Romantic coffee service &quot;Rüdesheimer Kaffee&quot;'
        expect(items[0].description).to start_with 'This is a romantic coffee service, made'
        expect(items[0].unit_price).to eq BigDecimal.new(8000, 4)
        expect(items[0].created_at).to eq DateTime.parse('2016-01-11 12:17:26 UTC')
        expect(items[0].updated_at).to eq DateTime.parse('1988-06-26 02:51:02 UTC')

        expect(items[1].id).to eq 263430957
        expect(items[1].name).to eq 'Custom Listing: Twenty booklets R.H. Life, Biographical in nature, own publishing 2014.'
        expect(items[1].description).to start_with 'Custom Listing: Twenty booklets R.H. Life'
        expect(items[1].unit_price).to eq BigDecimal.new(100000, 4)
        expect(items[1].created_at).to eq DateTime.parse('2016-01-11 17:41:20 UTC')
        expect(items[1].updated_at).to eq DateTime.parse('1974-11-29 08:58:13 UTC')

        expect(items[2].id).to eq 263500424
        expect(items[2].name).to eq 'Du Romantisme'
        expect(items[2].description).to start_with 'Acrylique sur toile exécutée en 2015'
        expect(items[2].unit_price).to eq BigDecimal.new(60000, 4)
        expect(items[2].created_at).to eq DateTime.parse('2016-01-11 11:30:35 UTC')
        expect(items[2].updated_at).to eq DateTime.parse('1986-12-21 16:16:32 UTC')
      end

      it 'adds merchant_id to Items' do
        items = described_class.parse(filename)

        expect(items[0].merchant_id).to eq 12334235
        expect(items[1].merchant_id).to eq 12335128
        expect(items[2].merchant_id).to eq 12334195
      end
    end
  end
end
