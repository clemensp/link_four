class HomeController < ApplicationController

def index
  @title = "Connect Four"

  @game = Game.create(:board_state => "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE",
                      :turn => "RED",
                      :ip => request.ip,
                      :game_state => "INPROGRESS") if Game.find_by_ip(request.ip).nil?
  @game = Game.find_by_ip(request.ip)
  @connect_four_engine = ConnectFourEngine.new(@game.board_state,
                                               @game.turn)
end

def new_game
  @game = Game.find_by_ip(request.ip)
  @game.game_state = "INPROGRESS"
  @game.board_state = "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
  @game.turn = "RED"
  @game.save
  flash[:notice] = "#{@game.turn.to_s} goes first"
  redirect_to root_path
end

def click_column
  @game = Game.find_by_ip(request.ip)
  @connect_four_engine = ConnectFourEngine.new(@game.board_state, 
                                               @game.turn)
  added = @connect_four_engine.add_to_column(params[:column].to_i)
  if added
    if @connect_four_engine.check_win
      @game.game_state = "DONE"
      flash[:notice] = "#{@connect_four_engine.turn.to_s} wins!" 
    elsif @connect_four_engine.check_draw
      @game.game_state = "DONE"
      flash[:notice] = "Game is a draw."
    else
      @connect_four_engine.toggle_turn
      flash[:notice] = "#{@connect_four_engine.turn.to_s} goes next..."
      end
    else
      flash[:error] = "piece not added" 
    end 

    @game.board_state = @connect_four_engine.get_board_state
    @game.turn = @connect_four_engine.get_turn
    @game.save
    redirect_to root_path
  end

end
