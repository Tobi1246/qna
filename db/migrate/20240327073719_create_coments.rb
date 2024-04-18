class CreateComents < ActiveRecord::Migration[6.1]
  def change
    create_table :coments do |t|
      t.text :body
      t.references :user, foreign_key: true, null: false
      t.references :comentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end