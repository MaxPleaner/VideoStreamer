class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.string :sender
      t.text :message

      t.timestamps
    end
  end
end
