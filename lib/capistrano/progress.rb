require_relative 'progress/parallel_status'
require_relative 'progress/server_with_roles'
require_relative 'progress/configuration/actions/progress'

class Capistrano::Configuration
  include Capistrano::Progress::Configuration::Actions::Progress
end
