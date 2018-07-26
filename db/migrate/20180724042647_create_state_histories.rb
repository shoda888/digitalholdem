class CreateStateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :state_histories do |t|
      t.string :state
      t.string :previous_state
      t.integer :stateable_id
      t.string :stateable_type

      t.timestamps
    end
  end
end
