require 'cgi'

module ApplicationHelper
  def letterboxd_link(film_name)
    search_name = CGI.escape film_name
    "https://letterboxd.com/search/#{search_name}/"
  end
end
