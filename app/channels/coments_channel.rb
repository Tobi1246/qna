class ComentsChannel < ApplicationCable::Channel
  def follow(data)
    stream_from 'coments'
  end
end
