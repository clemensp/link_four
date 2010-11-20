class HomeController < ApplicationController

  def index
    @title = "Connect Four"
    @connect_four_engine = ConnectFourEngine.new
  end

  def click_column
    @connect_four_engine.add_to_column(params[:column])
    redirect_to root_path
  end

end
