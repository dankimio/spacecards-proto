class RemoveUserIdFromCards < ActiveRecord::Migration[5.2]
  def change
    remove_reference :cards, :user, foreign_key: true
  end
end
