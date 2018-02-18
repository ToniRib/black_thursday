require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'csv/merchant_parser'
require_relative 'csv/item_parser'

class SalesEngine
  def self.from_csv(csv_files)
    merchants = Csv::MerchantParser.parse(csv_files[:merchants])
    items = Csv::ItemParser.parse(csv_files[:items])

    new(MerchantRepository.new(merchants), ItemRepository.new(items))
  end

  attr_reader :merchants, :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo
    @items = item_repo
  end
end
