ActiveRecord::Base.configurations = {'test' => {adapter: 'sqlite3', database: ':memory:'}}
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :name
      t.string :address
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up
