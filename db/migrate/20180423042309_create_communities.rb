class CreateCommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :communities do |t|
      t.string :aasm_state
      t.integer :round
      t.integer :game_id

      t.timestamps
    end
  end
end
