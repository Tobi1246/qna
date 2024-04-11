class ComentsController < ApplicationController

  before_action :set_coment, only: %i[destroy]

  def destroy
    @coment.destroy
  end

  private

  def set_coment
    @coment = Coment.find(params[:id])
  end
end
