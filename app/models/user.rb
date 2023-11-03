class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_questions, class_name: 'Question',
                           foreign_key: 'author_id',
                           dependent: :destroy
  has_many :created_answers, class_name: 'Answer',
                           foreign_key: 'author_id',
                           dependent: :destroy

  def author?(question_or_answer)
    self.id == question_or_answer.author_id
  end                   
end
