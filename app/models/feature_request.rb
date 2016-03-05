class FeatureRequest < ActiveRecord::Base
  belongs_to :client
  belongs_to :product
  validates_presence_of :client_id, :product_id, :client_priority, :title, :target_date

  before_save :store_client_priority
  attr_accessor :previous_client_priority

  def store_client_priority
    self.previous_client_priority = self.client_priority_was
  end

  def recalculate_priorities
    return if self.previous_client_priority == self.client_priority

    ids = FeatureRequest
      .where(client_id: self.client_id)
      .where.not(id: self.id)
      .order('client_priority, updated_by desc')
      .pluck(:id)

    index = self.client_priority - 1
    if index < ids.size
      ids.insert(index, self.id)
    else
      ids << self.id
    end

    ActiveRecord::Base.transaction do
      ids.each_with_index do |id, index|
        feature = FeatureRequest.find(id)
        client_priority = index + 1

        if feature.client_priority != client_priority
          feature.client_priority = client_priority
          feature.save!
        end
      end
    end
  end
end
