# == Schema Information
#
# Table name: films
#
#  id          :bigint           not null, primary key
#  name        :string
#  year        :integer
#  description :text
#  director    :string
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Film < ApplicationRecord
	has_many :film_taggings
	has_many :tags, through: :film_taggings
	has_many :comments

	def self.unsynced_film_names
		Gcs.download_index_file.reject do |film_name|
			Film.exists?(name: film_name)
		end
	end

	def self.create_from_movie_db_lookup(folder_name, movie_db_results)
		Film.create!(
			name: folder_name,
			description: movie_db_results[:details],
			year: DateTime.parse(movie_db_results[:date]).year,
			director: movie_db_results[:director],
			image_url: movie_db_results[:img_path],
		)
	end

	def get_files
		Gcs.get_files_in_folder(self.name)
	end

	def get_media_files
		video_formats = {
			".webm" => "video/webm",
			".mp4" => "video/mp4",
			".mpeg" => "video/mpeg",
			".mpg" => "video/mpeg",
			".ogg" => "video/ogg",
		}
		unsupported_video_formats = %w[.avi .mkv]
		subtitle_formats = %w[.srt .sub]

		files_by_extname = get_files.group_by { |file| File.extname(file.name) }

		{
			video: video_formats.each_with_object({}) do |(ext, media_type), memo|
				matches = files_by_extname[ext]
				next unless matches&.any?
				memo[media_type] ||= []
				memo[media_type].concat(matches)
			end,
			unsupported_video: unsupported_video_formats.flat_map do |ext|
				files_by_extname[ext] || []
			end,
			subtitle: subtitle_formats.flat_map do |ext|
				files_by_extname[ext] || []
			end
		}
	end
end
