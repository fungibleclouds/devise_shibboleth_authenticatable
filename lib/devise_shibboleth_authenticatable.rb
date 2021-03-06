# encoding: utf-8
require 'devise'

require 'devise_shibboleth_authenticatable/exception'
require 'devise_shibboleth_authenticatable/logger'
require 'devise_shibboleth_authenticatable/schema'
require 'devise_shibboleth_authenticatable/routes'

begin
  Rails::Engine
rescue
else
  module DeviseShibbolethAuthenticatable
    class Engine < Rails::Engine
    end
  end
end

# Get shibboleth information from config/shibboleth.yml now
module Devise
  # Allow logging
  mattr_accessor :shibboleth_logger
  @@shibboleth_logger = true
  
  # Add valid users to database
  mattr_accessor :shibboleth_create_user
  @@shibboleth_create_user = false
  
  mattr_accessor :shibboleth_config
  @@shibboleth_config = "#{Rails.root}/config/shibboleth.yml"
  
end

# Add shibboleth_authenticatable strategy to defaults.
#
Devise.add_module(:shibboleth_authenticatable,
                  :route => :shibboleth_authenticatable, 
                  :strategy   => true,
                  :controller => :shibboleth_sessions,
                  :model  => 'devise_shibboleth_authenticatable/model')
