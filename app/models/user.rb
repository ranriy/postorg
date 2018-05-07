class User < ActiveRecord::Base
  #email ka daalna h
  has_secure_password
  has_many :organizations
  has_many :joins
  has_many :organizations, through: :joins, dependent: :destroy
  validates :fname, :lname, presence: true, length: { in: 2..20 }
end
