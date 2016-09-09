Rails.application.routes.draw do
  get 'index/one'
  get 'index/two'

  namespace 'demo' do
    get 'index/one'
  end
end
