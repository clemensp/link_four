ConnectFour::Application.routes.draw do
  match "/:column" => "home#click_column"
  root :to => "home#index"
end
