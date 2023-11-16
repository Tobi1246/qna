class ChangeCorrectToBestAnswers < ActiveRecord::Migration[6.1]
  def change
    rename_column :answers, :correct, :best
    change_column :answers, :best, :boolean, default: false 
  end
end
