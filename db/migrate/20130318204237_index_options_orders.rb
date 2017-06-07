class IndexOptionsOrders < ActiveRecord::Migration
	def up
	  execute "CREATE INDEX orders_options ON orders USING GIN(options)"
	end

	def down
	  execute "DROP INDEX orders_options"
	end
end
