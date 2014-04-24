class CreateMandrillEvents < ActiveRecord::Migration
  def change
    create_table :mandrill_events do |t|
      t.integer :ts
      t.string :event_name
      t.string :url
      t.string :ip
      t.string :user_agent
      t.string :internal_id
      t.references :msg
      t.references :user_agent_parsed
      t.references :location

      t.timestamps
    end
    add_index :mandrill_events, :msg_id
    add_index :mandrill_events, :user_agent_parsed_id
    add_index :mandrill_events, :location_id
  end
end
