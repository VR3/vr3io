Rails.application.routes.draw do
  devise_for :users

  root "pages#show", page: "home"

  get "company" => "pages#company"
  get "privacy" => "pages#privacy"
  get "services" => "pages#services"
  get "contact" => "pages#contact"

  resources "projects"
  resources "jobs"
  resources "articles"

  match '/send_mail', to: 'pages#send_mail', via: 'post'

end
