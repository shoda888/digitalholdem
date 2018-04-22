class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :cardable, polymorphic: true
      t.string :suit
      t.integer :number

      t.timestamps
    end
  end
end
