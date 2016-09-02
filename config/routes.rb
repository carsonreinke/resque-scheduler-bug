Rails.application.routes.draw do
  mount Resque::Server, at: '/jobs'
end
