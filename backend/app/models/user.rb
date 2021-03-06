class User < ApplicationRecord
  has_many :tasks

  devise :database_authenticatable, :validatable

  attr_accessor :skip_password_validation

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
