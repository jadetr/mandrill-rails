class CreateMandrillOpens < ActiveRecord::Migration
  def change
    create_table :mandrill_opens do |t|
      t.integer :ts
      t.datetime :ts_dt
      t.string :ip
      t.string :location
      t.string :ua
      t.references :msg

      t.timestamps
    end
    add_index :mandrill_opens, :msg_id
  end
end
