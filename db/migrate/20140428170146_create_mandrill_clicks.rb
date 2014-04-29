class CreateMandrillClicks < ActiveRecord::Migration
  def change
    create_table :mandrill_clicks do |t|
      t.integer :ts
      t.datetime :ts_dt
      t.string :url
      t.string :ip
      t.string :location
      t.string :ua

      t.references :msg

      t.timestamps
    end
    add_index :mandrill_clicks, :msg_id
  end
end
