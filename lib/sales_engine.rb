require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'csv/merchant_parser'
require_relative 'csv/item_parser'
require_relative 'relationships'

class SalesEngine
  def self.from_csv(csv_files)
    merchants = Csv::MerchantParser.parse(csv_files[:merchants])
    items = Csv::ItemParser.parse(csv_files[:items])

    merchant_repo = MerchantRepository.new(merchants)
    item_repo = ItemRepository.new(items)

    Relationships.new.build!(merchant_repo, item_repo)

    new(merchant_repo: merchant_repo, item_repo: item_repo)
  end

  attr_reader :merchants, :items

  def initialize(merchant_repo:, item_repo:)
    @merchants = merchant_repo
    @items = item_repo
  end
end
