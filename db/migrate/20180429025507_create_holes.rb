class CreateHoles < ActiveRecord::Migration[5.1]
  def change
    create_table :holes do |t|
      t.integer :player_id
      t.integer :community_id
      t.integer :hand
      t.string :aasm_state
      t.boolean :out_come, default: false, null: false

      t.timestamps
    end
  end
end
