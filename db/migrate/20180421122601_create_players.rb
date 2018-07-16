class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :password
      t.integer :game_id
      t.integer :chip, default: 500
      t.integer :role, default: 3
      t.timestamps
    end
  end
end
