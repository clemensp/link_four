class Game < ActiveRecord::Base

  def inprogress?
    self.game_state == "INPROGRESS"
  end
end
