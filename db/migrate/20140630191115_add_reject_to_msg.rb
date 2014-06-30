class AddRejectToMsg < ActiveRecord::Migration
  def change
    add_column :mandrill_msgs, :reject, :string
    
  end
end
