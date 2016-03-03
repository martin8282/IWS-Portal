class CreateDefaultUser < ActiveRecord::Migration
  def up
    user = User.where(user_name: 'root', email: 'root@iws.com').first_or_create
    user.password = 'test1234'
    user.save!
  end

  def down
    user = User.where(user_name: 'root', email: 'root@iws.com').first
    user.destroy if user
  end
end
