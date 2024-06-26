class QuestionsController < ApplicationController
  include VotesControl
  include ComentControl
  
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show update destroy destroy_vote 
                                        good_vote bad_vote create_coment]
  after_action :publish_question, only: %i[create]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.links.build
  end

  def new
    @question = Question.new
    @question.links.build
  end

  def create
    @question = current_user.created_questions.build(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy
    redirect_to questions_path,alert: "Question deleted"
  end 

  def destroy_attach_file
    @file = ActiveStorage::Attachment.find(params[:id])
    @file.purge
  end

  private

  def set_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:name, :url, :_destroy])
  end

  def publish_question
    unless @question.errors.any?

      rendered_question = ApplicationController.render(
        partial: 'questions/question_broadcast',
        locals: { question: @question }
      )

      ActionCable.server.broadcast(
        'questions',
        { question: rendered_question, question_id: @question.id }
      )
    end
  end  
end
