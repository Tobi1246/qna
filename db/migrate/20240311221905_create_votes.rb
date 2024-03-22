class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :vote_score
      t.references :user, index: true, foreign_key: true, null: false
      t.references :votable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
