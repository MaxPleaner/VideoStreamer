class CreateFilms < ActiveRecord::Migration[7.0]
  def change
    create_table :films do |t|
      t.string :name
      t.integer :year
      t.text :description
      t.string :director
      t.string :image_url

      t.timestamps
    end
  end
end
