class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.boolean :vote_type
      t.references :user, index: true, foreign_key: true
      t.references :voteble, polymorphic: true

      t.timestamps
    end
  end
end
