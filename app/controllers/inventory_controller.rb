# app/controllers/inventory_events_controller.rb
class InventoryController < ApplicationController
  def stores_with_sales
    response = Store
      .select('stores.name AS storename, COUNT(inventories.store_id) AS sales')
      .joins('JOIN inventories ON stores.id = inventories.store_id')
      .group('stores.name, stores.id')
      .order('sales DESC')
  
    # Extract the relevant columns and convert to an array of hashes
    result = response.map { |row| { storename: row.storename, sales: row.sales } }

    render json: result
  end

  def popular_shoe
    most_popular_shoe = Shoe.joins('JOIN inventories ON shoes.id = inventories.shoe_id')
                            .group('shoes.name')
                            .order('COUNT(inventories.shoe_id) DESC')
                            .select('shoes.name')
                            .first
  
    if most_popular_shoe
      render json: { 'popular shoe model': most_popular_shoe.name }
    else
      render json: 'No sales data available'
    end
  end
end
  