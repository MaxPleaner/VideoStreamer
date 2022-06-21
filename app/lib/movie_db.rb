class MovieDb
	API_KEY = ENV.fetch("MOVIE_DB_API_KEY")
	ROOT_URL = "https://api.themoviedb.org/3"

	def self.get_config
		url = "#{ROOT_URL}/configuration?api_key=#{API_KEY}"
		data = JSON.parse(RestClient.get(url).body)
		{
			image_base_url: data["images"]["base_url"],
			image_size: data["images"]["backdrop_sizes"][0]
		}
	end

	CONFIG = get_config

	def self.get_genres
		url = "#{ROOT_URL}/genre/movie/list?api_key=#{API_KEY}"
		data = JSON.parse(RestClient.get(url).body)
		data["genres"].index_by { |genre| genre["id"] }.transform_values { |genre| genre["name"] }
	end

	GENRES = get_genres

	def self.build_full_img_path(partial_image_path)
		"#{CONFIG[:image_base_url]}#{CONFIG[:image_size]}#{partial_image_path}"
	end

	def self.lookup(query_name)
		query_name = query_name.force_encoding('ASCII')
		url = "#{ROOT_URL}/search/movie?api_key=#{API_KEY}&query=#{query_name}"
		results = JSON.parse(RestClient.get(url).body)["results"].first(30)
		results.map { |result| parse_details(result) }
	rescue => e
		nil
	end

	def self.get_credits(movie_id)
		url = "#{ROOT_URL}/movie/#{movie_id}/credits?api_key=#{API_KEY}"
		results = JSON.parse(RestClient.get(url).body)
		{
			director: results["crew"].find { |entry| entry["job"] == "Director" }&.dig("name")
		}
	end

	def self.parse_details(result)
		credits = get_credits(result["id"])
		{
			img_path: build_full_img_path(result["poster_path"]),
			date: result["release_date"],
			genres: result["genre_ids"].map { |genre_id| GENRES[genre_id] }.compact,
			details: result["overview"],
			name: result["original_title"],
			director: credits[:director],
		}
	end
end
