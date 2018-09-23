class CreateCommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :communities do |t|
      t.string :aasm_state
      t.integer :game_id
      t.integer :pod, default: 0
      t.integer :flop_pod, default: 0
      t.integer :river_pod, default: 0

      t.timestamps
    end
  end
end
