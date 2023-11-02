class AddAuthorQuestions < ActiveRecord::Migration[6.1]
  def self.up
    change_table :questions do |t|
      t.references :author, foreign_key: { to_table: :users}, null: false, default: 1
    end
  end
  def self.down
    change_table :questions do |t|
      t.remove :author_id
    end
  end  
end
