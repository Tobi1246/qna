class LinksController < ApplicationController
  before_action :authenticate_user!, except: %i[destroy] 
  before_action :set_link, only: %i[destroy]

  def destroy
    @link.destroy
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end
end
