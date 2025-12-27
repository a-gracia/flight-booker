class ChangeFlights < ActiveRecord::Migration[8.1]
  change_table :flights do |t|
    t.rename :arrival_airport, :arrival_airport_id
    t.rename :departure_airport, :departure_airport_id
  end
end
