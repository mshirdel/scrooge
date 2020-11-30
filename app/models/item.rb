class Item < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_and_belongs_to_many :tags

  validates :name, presence: true  
  validates :price, presence: true  
  validates :date, presence: true  

  def item_type_option
    [["Expense", "Exp"],["Income", "In"]]
  end
end
