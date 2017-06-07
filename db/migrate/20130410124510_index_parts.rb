class IndexParts < ActiveRecord::Migration
  def up
  	execute "CREATE INDEX parts_title ON parts USING gin(to_tsvector('ru', title))"
  end

  def down
  	execute "DROP INDEX parts_title"
  end
end
