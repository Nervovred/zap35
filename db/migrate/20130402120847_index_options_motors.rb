class IndexOptionsMotors < ActiveRecord::Migration
	def up
	  execute "CREATE INDEX motors_options ON motors USING GIN(options)"
	end

	def down
	  execute "DROP INDEX motors_options"
	end
end
