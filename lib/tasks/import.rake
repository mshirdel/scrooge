require 'csv'

namespace :import do
  desc 'TODO'
  task csv: :environment do
    file_name = "#{Rails.root}/tmp/data-1606834981140.csv"
    puts file_name
    CSV.open(file_name, 'rb') do |csv|
      data = csv.read
      data.shift
      data.each do |row|
        item = Item.new
        item.user_id = 1
        item.name = row[3]
        item.price = row[4]
        item.date = row[5]
        item.group_id = row[7]
        item.item_type = row[6]
        item.save!
      end
    end
  end

  desc 'TODO'
  task add_item: :environment do
    item = Item.new
    item.user_id = 1
    item.name = 'test item from'
    item.price = 100
    item.date = '2020-01-01'
    item.group_id = 1
    item.item_type = 'Exp'
    item.save!
  end
end
