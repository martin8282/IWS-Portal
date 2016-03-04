class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user

  def set_current_user
    User.current = current_user
  end

  protected

  def assign_attribute(object, attribute, value)
    if object.is_a?(ActiveRecord::Base) && object.respond_to?("#{attribute}=")
      begin
        set_attribute_value(object, attribute, value)
      rescue
        fail "Invalid value for #{attribute.humanize}: #{value}"
      end
    else
      fail "#{object.class.name} doesn't have attribute #{attribute}"
    end
  end

  def assign_attributes(object, attributes, ignore = [])
    fail 'Attributes should be a hash' unless attributes.is_a?(Hash)

    attributes.each { |attribute, value| assign_attribute(object, attribute, value) unless ignore.include?(attribute) }
  end

  private

  def set_attribute_value(object, attribute, value)
    if object.class.columns_hash[attribute].type == :date
      object.send("#{attribute}=", value.blank? ? nil : Date.strptime(value, '%m/%d/%Y'))
    else
      object.send("#{attribute}=", value)
    end
  end
end
