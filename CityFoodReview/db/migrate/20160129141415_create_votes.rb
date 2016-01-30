class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :voter
      t.text :comment
      t.string :vote
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
