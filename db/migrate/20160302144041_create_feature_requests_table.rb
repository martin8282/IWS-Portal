class CreateFeatureRequestsTable < ActiveRecord::Migration
  def change
    create_table(:clients, force: true) do |t|
      t.string :name, limit: 256, null: false
    end

    create_table(:products, force: true) do |t|
      t.string :name, limit: 256, null: false
    end

    create_table(:feature_requests, force: true) do |t|
      t.string :title, limit: 256, null: false
      t.text :description
      t.references :client, null: false
      t.references :product, null: false
      t.integer :client_priority, null: false
      t.date :target_date
      t.string :url, limit: 512
      t.date :created_at
      t.integer :created_by
      t.date :updated_at
      t.integer :updated_by
    end

    add_index :feature_requests, :client_id
    add_index :feature_requests, :product_id
  end
end
