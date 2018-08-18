class RenameDueOnToDueAtInCards < ActiveRecord::Migration[5.2]
  def change
    rename_column :cards, :due_on, :due_at
  end
end
