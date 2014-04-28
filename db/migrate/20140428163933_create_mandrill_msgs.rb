class CreateMandrillMsgs < ActiveRecord::Migration
  def change
    create_table :mandrill_msgs do |t|
      t.string :internal_id
      t.string :internal_version
      t.string :email
      t.text :metadata
      t.string :sender
      t.string :state
      t.string :subject
      t.text :tags
      t.integer :ts
      t.datetime :ts_dt
      t.references :email_event
      t.timestamps
    end
    
    add_index :mandrill_msgs, :email_event_id
    
  end
end
