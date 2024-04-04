class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_badges
  has_many :badges, through: :user_badges, dependent: :destroy

  has_many :created_questions, class_name: 'Question',
                           foreign_key: 'author_id',
                           dependent: :destroy
  has_many :created_answers, class_name: 'Answer',
                           foreign_key: 'author_id',
                           dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :coments, dependent: :destroy                        

  def author?(question_or_answer)
    self.id == question_or_answer.author_id
  end                   
end
