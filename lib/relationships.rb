class Relationships
  def build!(merchant_repo, item_repo)
    connect_merchants_to_items(item_repo, merchant_repo)
    connect_items_to_merchant(item_repo, merchant_repo)
  end

  private

  def connect_items_to_merchant(item_repo, merchant_repo)
    item_repo.all.each do |item|
      item.merchant = merchant_repo.find_by_id(item.merchant_id)
    end
  end

  def connect_merchants_to_items(item_repo, merchant_repo)
    merchant_repo.all.each do |merchant|
      merchant.items = item_repo.find_all_by_merchant_id(merchant.id)
    end
  end
end
