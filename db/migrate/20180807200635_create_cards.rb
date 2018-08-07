class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.text :front, null: false
      t.text :back, null: false
      t.float :easiness_factor, default: 2.5
      t.integer :repetitions, default: 0
      t.integer :interval, default: 0
      t.date :due_on
      t.datetime :recalled_at

      t.timestamps
    end
  end
end
