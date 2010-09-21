require 'yaml_db'

class ExportExtension < Radiant::Extension
  version "0.1"
  description "An extension version of yaml_db which exports schemas in order to support extension migrations"
  url "http://github.com/squaretalent/radiant-export-extension"

  def activate
    # Models
    User.send :include, Scoped::Models::User
    
    # Controllers
    ApplicationController.send :include, Scoped::Lib::LoginSystem
  end
end