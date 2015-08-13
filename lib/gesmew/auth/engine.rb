require 'devise'
require 'devise-encryptable'

module Gesmew
  module Auth
    class Engine < Rails::Engine
      isolate_namespace Gesmew
      engine_name 'gesmew_auth'

      initializer "gesmew.auth.environment", :before => :load_config_initializers do |app|
        Gesmew::Auth::Config = Gesmew::AuthConfiguration.new
      end

      initializer "gesmew_auth_devise.set_user_class", :after => :load_config_initializers do
        Gesmew.user_class = "Gesmew::User"
      end

      initializer "gesmew_auth_devise.check_secret_token" do
        if Gesmew::Auth.default_secret_key == Devise.secret_key
          puts "[WARNING] You are not setting Devise.secret_key within your application!"
          puts "You must set this in config/initializers/devise.rb. Here's an example:"
          puts " "
          puts %Q{Devise.secret_key = "#{SecureRandom.hex(50)}"}
        end
      end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
        if Gesmew::Auth::Engine.backend_available?
          Rails.application.config.assets.precompile += [
            'lib/assets/javascripts/gesmew/backend/gesmew_auth.js',
            'lib/assets/javascripts/gesmew/backend/gesmew_auth.css'
          ]
          Dir.glob(File.join(File.dirname(__FILE__), "../../controllers/backend/*/*/*_decorator*.rb")) do |c|
            Rails.configuration.cache_classes ? require(c) : load(c)
          end
        end
        if Gesmew::Auth::Engine.frontend_available?
          Rails.application.config.assets.precompile += [
            'lib/assets/javascripts/gesmew/frontend/gesmew_auth.js',
            'lib/assets/javascripts/gesmew/frontend/gesmew_auth.css'
          ]
          Dir.glob(File.join(File.dirname(__FILE__), "../../controllers/frontend/*/*_decorator*.rb")) do |c|
            Rails.configuration.cache_classes ? require(c) : load(c)
          end
        end
        ApplicationController.send :include, Gesmew::AuthenticationHelpers
      end

      def self.backend_available?
        @@backend_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('Gesmew::Backend::Engine')
      end

      def self.dash_available?
        @@dash_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('Gesmew::Dash::Engine')
      end

      def self.frontend_available?
        @@frontend_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('Gesmew::Frontend::Engine')
      end

      if self.backend_available?
        paths["app/controllers"] << "lib/controllers/backend"
        paths["app/views"] << "lib/views/backend"
      end

      if self.frontend_available?
        paths["app/controllers"] << "lib/controllers/frontend"
        paths["app/views"] << "lib/views/frontend"
      end

      config.to_prepare &method(:activate).to_proc
    end
  end
end
