class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.jsonb :board, null: false
      t.integer :mines, null: false
      t.integer :rows, null: false
      t.integer :cols, null: false
      t.timestamps
    end
  end
end
