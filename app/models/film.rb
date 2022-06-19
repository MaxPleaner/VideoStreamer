# == Schema Information
#
# Table name: films
#
#  id          :bigint           not null, primary key
#  name        :string
#  year        :integer
#  description :text
#  director    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Film < ApplicationRecord
	def self.unsynced_film_names
		Gcs.download_index_file.reject do |film_name|
			Film.exists?(name: film_name)
		end
	end

	def self.create_from_movie_db_lookup(folder_name, movie_db_results)
		Film.create!(
			name: folder_name,
			description: movie_db_results[:details],
			year: DateTime.parse(movie_db_results[:date]).year
		)
	end
end
