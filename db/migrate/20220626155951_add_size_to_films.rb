class AddSizeToFilms < ActiveRecord::Migration[7.0]
  def change
    add_column :films, :size, :float, default: -1.0, comment: "in megabytes"
  end
end
