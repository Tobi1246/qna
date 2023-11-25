module Badges  
  class BadgeBestAnswer < AbstractBadgeSpec
    def satisfied?
      @answer.best? unless duplicate?
    end

    def duplicate?
       @name = "Best answer in question:" + @answer.question.title
       @answer_author.badges.exists?(name: @name)
    end
  end
end
