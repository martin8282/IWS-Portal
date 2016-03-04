class User < ActiveRecord::Base
  has_one :profile

  devise :database_authenticatable

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if conditions.key?(:login)
      login = conditions.delete(:login).downcase
      where(conditions.to_h).where('lower(user_name) = ? OR lower(email) = ?', login, login).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(value)
    Thread.current[:user] = value
  end
end
