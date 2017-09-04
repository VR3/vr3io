Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "pages#show", page: "home"

  resources "projects"
  resources "jobs"
  resources "articles"

  match '/send_mail', to: 'pages#send_mail', via: 'post'

end
