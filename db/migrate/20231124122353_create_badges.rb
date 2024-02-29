class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.text :name, null: false
      t.text :img, null: false
      t.text :conditions, null: false
      t.text :conditions_params      

      t.timestamps
    end
  end
end
