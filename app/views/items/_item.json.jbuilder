json.extract! item, :id, :name, :price, :date, :user_id, :group_id, :item_type, :created_at, :updated_at
json.url item_url(item, format: :json)
