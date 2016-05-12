class CreatePincodes < ActiveRecord::Migration
  def change
    create_table :pincodes do |t|
      t.integer :timestamp
      t.string :office_name
      t.string :pincode, :null => false
      t.string :office_type
      t.string :delivery_status
      t.string :division_name
      t.string :region_name
      t.string :circle_name
      t.string :taluk
      t.string :district_name
      t.string :state_name
      t.string :telephone
      t.string :related_sub_office
      t.string :related_head_office

      t.timestamps null: false
    end
  end
end
