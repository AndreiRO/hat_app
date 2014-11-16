Rails.application.routes.draw do
  
  get '/' => 'hats#index'
  get 'hats/new' => 'hats#new'
  get '/hats/:id' =>'hats#show'   
  patch '/hats/:id' =>'hats#update'   
  delete '/hats/:id' =>'hats#destroy'   
  get 'hats/:id/edit' => 'hats#edit' 
  post 'hats/' => 'hats#create'

end
