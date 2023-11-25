class AbstractBadgeSpec
  def initialize(answer, conditions_params)
    @answer = answer
    @answer_author = answer.author
    @conditions_params = conditions_params
  end

  def satisfied?
    raise "#{__method__} unfifined for #{self.class} "
  end
end
