module ComentsControl
  extend ActiveSupport::Concern

  included do
    before_action :comentable, only: %i[create_coment]
    before_action :set_coment, only: %i[destroy_coment]
  end  

  def create_coment
    c = comentable.coments.new(comentable_params)
    if c.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render root
    end    
  end

  def destroy_coment
    @coment.destroy
  end  

  private

  def set_coment
    @coment = Coment.find(params[:id])
  end

  def comentable
    @answer || @question
  end

  def comentable_params
    params.require(:coment).permit(:body).merge(user: current_user)
  end
end