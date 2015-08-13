# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'gesmew_auth_devise'
  s.version     = '1.0.0'
  s.summary     = 'Provides authentication and authorization services for use with Gesmew by using Devise and CanCan.'
  s.description = s.summary

  s.required_ruby_version = '>= 2.1.0'

  s.author      = 'Michail Gumbs'
  s.email       = 'mjgumbs.200@gmail.com'
  s.homepage    = 'http://'
  s.license     = %q{BSD-3}

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  gesmew_version = '~> 1.0.0.beta'

  s.add_dependency 'devise', '~> 3.4.1'
  s.add_dependency 'devise-encryptable', '0.1.2'
  s.add_dependency 'json'
  s.add_dependency 'multi_json'
  s.add_dependency 'gesmew_core', gesmew_version

  s.add_development_dependency 'capybara', '~> 2.4.1'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'database_cleaner', '~> 1.2.0'
  s.add_development_dependency 'email_spec', '~> 1.5.0'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'poltergeist', '~> 1.5'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec-rails', '~> 3.3'
  s.add_development_dependency 'sass-rails', '~> 5.0.3 '
  s.add_development_dependency 'shoulda-matchers', '~> 2.6.2'
  s.add_development_dependency 'simplecov', '~> 0.9.0'
  s.add_development_dependency 'gesmew_backend', gesmew_version
  s.add_development_dependency 'gesmew_frontend', gesmew_version
  s.add_development_dependency 'sqlite3'
end
