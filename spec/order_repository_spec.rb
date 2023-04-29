require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_ceo_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it 'gets all the orders' do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 2

    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'Nate'
    expect(orders[0].date).to eq '2012-11-04'
    expect(orders[0].item_id).to eq 1

    expect(orders[1].id).to eq 2
    expect(orders[1].customer_name).to eq 'Will'
    expect(orders[1].date).to eq '2012-07-09'
    expect(orders[1].item_id).to eq 2
  end

  it 'gets a single order' do
    repo = OrderRepository.new

    order = repo.find(1)

    expect(order.id).to eq 1
    expect(order.customer_name).to eq 'Nate'
    expect(order.date).to eq '2012-11-04'
    expect(order.item_id).to eq 1
  end

  it 'gets a differnt single order' do
    repo = OrderRepository.new

    order = repo.find(2)

    expect(order.id).to eq 2
    expect(order.customer_name).to eq 'Will'
    expect(order.date).to eq '2012-07-09'
    expect(order.item_id).to eq 2
  end

  it 'creates a new order' do
    new_order = Order.new
    new_order.customer_name = 'George'
    new_order.date = '2023-07-04'
    new_order.item_id = 2

    repo = OrderRepository.new
    repo.create(new_order)

    orders = repo.all
    expect(orders[-1].customer_name).to eq 'George'
    expect(orders[-1].date).to eq '2023-07-04'
    expect(orders[-1].item_id).to eq 2
  end
end