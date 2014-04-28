class CreateMandrillMsgs < ActiveRecord::Migration
  def change
    create_table :mandrill_msgs do |t|
      t.string :internal_id
      t.integer :ts
      t.datetime :ts_dt
      
      t.string :internal_version
      t.string :email
      t.string :sender
      t.string :subject
      t.text :tags
      t.text :metadata
      t.text :resends
      
      t.string :state
      t.string :subaccount
      t.string :diag
      t.string :bounce_description
      t.string :template
            
      t.references :email_event
      t.timestamps
    end
    
    add_index :mandrill_msgs, :email_event_id
    
  end
end
