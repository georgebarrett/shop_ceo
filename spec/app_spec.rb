require_relative '../app'

RSpec.describe Application do
  
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_ceo_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_ceo_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
  end

  it 'when a user selects 1, all the items are printed' do
    io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n \nWhat would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n\n\nEnter your choice:").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n").ordered
      expect(io).to receive(:puts).with("#1 Cup - Unit price: 4.99 - Quantity: 8").ordered
      expect(io).to receive(:puts).with("#2 Lamp - Unit price: 9.98 - Quantity: 6").ordered

      app = Application.new('shop_ceo_test', io, OrderRepository.new, ItemRepository.new)
      app.run
  end

end



