class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[create destroy]  
  before_action :find_question, only: %i[new create]
  before_action :set_answer, only: %i[destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@question), notice: "Answer create"
    else
      redirect_to question_path(@question), notice: "Answer not create"
    end
  end

  def destroy
    @answer.destroy
    redirect_to @answer.question, notice: 'Answer has bin deleted'
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
