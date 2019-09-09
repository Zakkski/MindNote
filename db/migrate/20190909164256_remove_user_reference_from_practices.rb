class RemoveUserReferenceFromPractices < ActiveRecord::Migration[5.2]
  def change
    add_reference :practices, :playlist, foreign_key: true
    remove_reference :practices, :user, foreign_key: true
  end
end
