require "csv"

Product.destroy_all
Category.destroy_all

csv_file = Rails.root.join('db', 'products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

products.each do |product|
  category_name = product['category']
  category = Category.find_or_create_by(name: category_name)

  category.products.create(
    title: product['name'],
    description: product['description'],
    price: product['price'],
    stock_quantity: product['stock_quantity']
  )
end

puts "Imported #{Category.count} categories and #{Product.count} products."
