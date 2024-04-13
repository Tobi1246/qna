module ComentControl
  extend ActiveSupport::Concern

  included do
    before_action :comentable, only: %i[create_coment]
    after_action :publish_coment, only: %i[create_coment]
  end  

  def create_coment
    @coment = comentable.coments.create(comentable_params)
    @comentable = comentable
  end

  private

  def publish_coment
    unless @coment.errors.any?
      
      rendered_coment = ApplicationController.render(
        partial: 'coments/coment',
        locals: { coment: @coment }
      )

      ActionCable.server
                 .broadcast("question-#{set_question_id}",
                            {
                              coment: rendered_coment,
                              comentable: @comentable.class.to_s.downcase
                            })
    end
  end

  def set_question_id
    if @comentable.class.to_s == 'Answer'
      @comentable.question.id
    else
      @comentable.id
    end
  end

  def comentable
    @answer || @question
  end

  def comentable_params
    params.require(:coment).permit(:body).merge(user: current_user)
  end
end