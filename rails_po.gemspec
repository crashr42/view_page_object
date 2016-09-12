$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rails_po/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'view_page_object'
  s.version     = RailsPo::VERSION
  s.authors     = ['Nikita Koshkin']
  s.email       = ['nikita.kem@gmail.com']
  s.homepage    = 'https://github.com/crashr42/view_page_object'
  s.summary     = 'Page objects for rails views.'
  s.description = 'Page objects for rails views.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.0', '>= 5.0.0.1'

  s.add_development_dependency 'sqlite3'
end
