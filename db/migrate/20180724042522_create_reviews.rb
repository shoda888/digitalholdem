class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :community_id
      # t.integer :player_id
      t.integer :confidence

      t.timestamps
    end
  end
end
