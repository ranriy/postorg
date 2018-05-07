class Organization < ActiveRecord::Base
  belongs_to :user
  has_many :joins
  has_many :users, through: :joins, dependent: :destroy
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
end
