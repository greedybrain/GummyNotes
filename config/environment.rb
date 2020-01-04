ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# SET CONNECTION TO DATABASE
# def fi_check_migration
# 	begin
# 		ActiveRecord::Migration.check_pending!
# 	rescue ActiveRecord::PendingMigrationError
# 		raise ActiveRecord::PendingMigrationError.new "Migrations are pending. To resolve this issue, run: rake db:migrate SINATRA_ENV=#{ENV['SINATRA_ENV']}"
# 	end
# end

# ActiveRecord::Base.establish_connection(
# 	:adapter => "sqlite3",
# 	:database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "/public/css", "*.css")].each {|f| require f}

require_all "app"
