Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get ":page" => "pages#show"

  resources "projects"

  match '/send_mail', to: 'pages#send_mail', via: 'post'

  root "pages#show", page: "home"

  
end
