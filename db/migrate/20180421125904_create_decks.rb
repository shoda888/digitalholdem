class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|

      t.timestamps
    end
  end
end
