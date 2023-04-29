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

  def find(id)
    sql = 'SELECT * FROM items WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    return record_to_item_object(record)
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.quantity]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
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