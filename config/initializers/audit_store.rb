module AuditSetter
  def on_create
    self.created_by = User.current.id if self.respond_to?(:created_by) && User.current
  end

  def on_save
    self.updated_by = User.current.id if self.respond_to?(:updated_by) && User.current
  end
end

ActiveRecord::Base.include(AuditSetter)
ActiveRecord::Base.before_create(:on_create)
ActiveRecord::Base.before_save(:on_save)