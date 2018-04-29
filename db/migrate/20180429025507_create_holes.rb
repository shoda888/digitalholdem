class CreateHoles < ActiveRecord::Migration[5.1]
  def change
    create_table :holes do |t|
      t.integer :player_id
      t.string :hand

      t.timestamps
    end
  end
end
