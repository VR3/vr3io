Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "pages#show", page: "home"

  get ":page" => "pages#show"


  resources "projects"
  resources "jobs"

  match '/send_mail', to: 'pages#send_mail', via: 'post'

end
