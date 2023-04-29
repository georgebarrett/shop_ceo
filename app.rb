require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts "Welcome to the shop management program!\n \nWhat would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n\n\nEnter your choice:"
    result = @io.gets.chomp.to_i
    case result
      when 1
        @io.puts "\nHere's a list of all shop items:\n"
        @item_repository.all.each do |item|
          @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
        end
      when 2
        @io.puts "\nPlease enter the NAME of the item and hit enter"
        new_name = @io.gets.chomp.to_s
        @io.puts "\nPlease enter the UNIT PRICE of the item and hit enter"
        new_unit_price = @io.gets.chomp.to_f
        @io.puts "\nPlease enter the STOCK QUANTITY of the item and hit enter"
        new_quantity = @io.gets.chomp.to_i
        @io.puts "\nHere's a list of all shop items:\n"
        
        new_item = Item.new
        new_item.name, new_item.unit_price, new_item.quantity = new_name, new_unit_price, new_quantity
        @item_repository.create(new_item)
        @item_repository.all.each do |item|
          @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
        end
    end
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop_ceo',
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end