class CreateMandrillUserAgentParseds < ActiveRecord::Migration
  def change
    create_table :mandrill_user_agent_parseds do |t|
      t.boolean :mobile
      t.string :os_company
      t.string :os_company_url
      t.string :os_family
      t.string :os_icon
      t.string :os_name
      t.string :os_url
      t.string :type
      t.string :ua_company
      t.string :ua_company_url
      t.string :ua_family
      t.string :ua_icon
      t.string :ua_name
      t.string :ua_url
      t.string :ua_version
      t.references :email_event
      t.timestamps
    end
    
    add_index :mandrill_user_agent_parseds, :email_event_id
    
  end
end
