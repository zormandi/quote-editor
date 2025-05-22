class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  belongs_to :company

  def name
    self.email.split('@').first.capitalize
  end
end
