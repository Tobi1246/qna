class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[create destroy update]  
  before_action :find_question, only: %i[create edit]
  before_action :set_answer, only: %i[destroy update mark_best]

  def create
    @answer = @question.answers.create(answer_params)
  end

  def destroy
    @answer.destroy
  end

  def update
    @answer.update(answer_params)
  end 

  def mark_best
    @answer.mark_best
    @answers = @answer.question.answers
  end 

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end  

  def answer_params
    params.require(:answer).permit(:body, :correct).merge(author: current_user)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end  
end
