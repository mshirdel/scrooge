class Tag < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  validates :name, presence: true
end
