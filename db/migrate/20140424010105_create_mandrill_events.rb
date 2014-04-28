class CreateMandrillEvents < ActiveRecord::Migration
  def change
    create_table :mandrill_email_events do |t|
      t.integer :ts
      t.datetime :ts_dt
      t.string :event
      t.string :url
      t.string :ip
      t.string :user_agent
      t.string :internal_id
      
      t.timestamps
    end
    
  end
end
