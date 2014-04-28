class CreateMandrillLocations < ActiveRecord::Migration
  def change
    create_table :mandrill_locations do |t|
      t.string :city
      t.string :country
      t.string :country_short
      t.string :latitude
      t.string :longitude
      t.string :postal_code
      t.string :region
      t.string :timezone
      t.references :email_event
      t.timestamps
    end
    
    add_index :mandrill_locations, :email_event_id
  end
end
