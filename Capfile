# Load DSL and Setup Up Stages
# require 'rvm1/capistrano3'
require 'capistrano/setup'
set :stage, :production
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
install_plugin Capistrano::Puma
require 'capistrano/delayed_job'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }