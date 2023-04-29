require_relative './order'

class OrderRepository

  def all
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      orders << record_to_order_object(record)
    end
    return orders
  end

  def find(id)
    sql = 'SELECT * FROM orders WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    return record_to_order_object(record)
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);'
    sql_params = [order.customer_name, order.date, order.item_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private

  def record_to_order_object(record)
    order = Order.new
    
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id'].to_i

    return order
  end

end