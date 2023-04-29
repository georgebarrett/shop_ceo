require_relative './item'

class ItemRepository

  def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      items << record_to_item_object(record)
    end
    return items
  end


  private

  def record_to_item_object(record)
    item = Item.new
    
    item.id = record['id'].to_i
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity'].to_i

    return item
  end

end