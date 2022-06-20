class RemoveFilmIdFromTags < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tags, :film, null: false, foreign_key: true
  end
end
