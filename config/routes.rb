ConnectFour::Application.routes.draw do
  match "/new_game" => "home#new_game"
  match "/:column" => "home#click_column"
  root :to => "home#index"
end
