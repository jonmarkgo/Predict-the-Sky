PredictTheSky::Application.routes.draw do

  root :to => 'subscribers#new'
  resources :subscribers, :only => [:new, :create]


end
