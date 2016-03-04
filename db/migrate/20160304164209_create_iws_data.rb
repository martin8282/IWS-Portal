class CreateIwsData < ActiveRecord::Migration
  def change
    clients = ['Client A', 'Client B', 'Client C']
    clients.each do |name|
      client = Client.where(name: name).first_or_create
      client.save!
    end

    products = ['Policies', 'Billing', 'Claims', 'Reports']
    products.each do |name|
      product = Product.where(name: name).first_or_create
      product.save!
    end

    root = User.where(user_name: 'root', email: 'root@iws.com').first_or_create(password: 'test1234')
    root.save!
  end
end

