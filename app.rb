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