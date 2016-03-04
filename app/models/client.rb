class Client < ActiveRecord::Base
  has_many :feature_requests
end
