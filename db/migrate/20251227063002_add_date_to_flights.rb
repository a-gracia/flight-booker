class AddDateToFlights < ActiveRecord::Migration[8.1]
  change_table :flights do |t|
    t.remove :start_datetime
    t.date :date
    t.time :time
  end
end
