class AddSizeToFilms < ActiveRecord::Migration[7.0]
  def change
    add_column :films, :size, :float, comment: "in megabytes"
  end
end
