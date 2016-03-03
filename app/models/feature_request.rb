class FeatureRequest < ActiveRecord::Base
  belongs_to :client
  belongs_to :product
  validates_presence_of :client_id, :product_id, :client_priority, :title
end
