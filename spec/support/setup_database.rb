ActiveRecord::Base.establish_connection(adapter: :sqlite3, database: ":memory:", pool: 5, timeout: 5000)

class CreateAllTables < ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :name
      t.string :address
      t.string :country
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up
