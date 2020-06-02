Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get "/contacts" => "contacts#index"

    get "/contacts/:id" => "contacts#show"

    get "/contacts" => "contacts#show"

    post "/contacts" => "contacts#create"

    patch "/contacts/:id" => "contacts#update"

    delete "contacts/:id" => "contacts#destroy"


  end
end
