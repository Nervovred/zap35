class AddTSvectorToParts < ActiveRecord::Migration
  def up
    add_column :parts, :title_tsv, :tsvector
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON parts 
    FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(title_tsv, 'pg_catalog.ru', title);"
  end
  def down
  	execute "DROP TRIGGER tsvectorupdate ON parts"
  	remove_column :parts, :title_tsv
  end
end
