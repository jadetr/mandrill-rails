class CreateMandrillSmtpEvents < ActiveRecord::Migration
  def change
    create_table :mandrill_smtp_events do |t|
      t.integer :ts
      t.datetime :ts_dt
      t.string :type
      t.string :diag
      t.string :source_ip
      t.string :destination_ip
      t.integer :size
      t.references :msg

      t.timestamps
    end
    add_index :mandrill_smtp_events, :msg_id
  end
end
