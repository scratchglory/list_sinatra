require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# Must be placed above all controllers
# to use PATCH, PUT, DELETE requests
use Rack::MethodOverride
run ApplicationController
