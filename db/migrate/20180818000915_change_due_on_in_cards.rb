class ChangeDueOnInCards < ActiveRecord::Migration[5.2]
  def change
    change_column :cards, :due_on, :datetime
  end
end
