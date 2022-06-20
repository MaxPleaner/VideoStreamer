class CreateFilmTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :film_taggings do |t|
      t.references :film, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
