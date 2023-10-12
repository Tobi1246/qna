class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.boolean :correct , default: true, null: false
      t.text :body, null: false
      t.references :question, null: false, foreing_key: true

      t.timestamps
    end
  end
end
