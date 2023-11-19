
User.delete_all
Product.delete_all

10.times do
  user = User.create! email: Faker::Internet.email, password:'localis1234'
  puts "created a new user: #{user.email}"

  2.times do
    product = Product.create! title: Faker::Commerce.product_name,
                              price: rand(10...100),
                              published: true,
                              user_id: user.id
    puts "created #{product.title} for #{user.email}"
  end
end
