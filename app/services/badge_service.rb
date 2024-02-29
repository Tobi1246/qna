class BadgeService
  CONDUCTION = {
    best_answer: Badges::BadgeBestAnswer
  }.freeze

  def initialize(answer)
    @answer = answer
    @answer_author = @answer.author
  end

  def call
    Badge.find_each do |badge|
      condition = CONDUCTION[badge.conditions.to_sym].new(@answer, badge.conditions_params)
      add_badges(badge) if condition.satisfied?
    end
  end

  private

  def add_badges(badge)
    @answer_author.badges.create(name: "Best answer in question:#{@answer.question.title}",
                          img: badge.img, conditions: badge.conditions)
    return
  end
end
