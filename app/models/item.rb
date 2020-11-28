class Item < ApplicationRecord
  belongs_to :user
  belongs_to :group

  def item_type_option
    [["Expense", "Exp"],["Income", "In"]]
  end
end
