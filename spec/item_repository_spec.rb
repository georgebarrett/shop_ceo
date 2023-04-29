require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_ceo_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it 'gets all the items' do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 2 # =>  2

    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'Cup'
    expect(items[0].unit_price).to eq'4.99'
    expect(items[0].quantity).to eq 8

    expect(items[1].id).to eq 2
    expect(items[1].name).to eq 'Lamp'
    expect(items[1].unit_price).to eq  '9.98'
    expect(items[1].quantity).to eq 6
  end

end