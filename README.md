# IWS-Portal
IWS Test portal

This application was created using following tech stack:

Ruby on Rails (Rails 4.2). 
Bootstrap for creation of responsive UI.

Database scheme is:
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
     t.datetime :created_at
     t.integer :created_by
     t.datetime :updated_at
     t.integer :updated_by
   end

   add_index :feature_requests, :client_id
   add_index :feature_requests, :product_id
   add_index :feature_requests, :client_priority

Initial migration was also created and filled with data.

Web application is avaliable at following URL:

http://show2me.herokuapp.com/ 

login: root 
password: test1234.

Mane page of the application gives user ability to create and edit Feature Requests. User also has ability to filter existing requests by date and client.

Priorities are recalculated after each save operation.

ajax methodology(technology) was used for almost all operations.