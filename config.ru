require './config/environment'

# begin
# 	fi_check_migration

	# use Rack::MethodOverride
	
	# use TrashController
	# use GummyNoteController
	# run ApplicationController # or whatever the app controller module/class name you want eg. App
# rescue ActiveRecord::PendingMigrationError => err
# 	STDERR.puts err
# 	exit 1
# end
use Rack::MethodOverride
	
use TrashController
use GummyNoteController
run ApplicationController 


