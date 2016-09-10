Rails.application.routes.draw do
  get 'index/one'
  get 'index/two'
  get 'index/three'

  namespace 'demo' do
    get 'index/one'
  end
end
