class CreateHats < ActiveRecord::Migration
  def change
    create_table :hats do |t|

      t.timestamps
    end
  end
end
