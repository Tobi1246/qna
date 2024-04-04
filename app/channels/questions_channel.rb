class QuestionsChannel < ApplicationCable::Channel
  def do_something(data)
    Rails.logger.info data
  end  
end
