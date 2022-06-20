# == Schema Information
#
# Table name: film_taggings
#
#  id         :bigint           not null, primary key
#  film_id    :bigint           not null
#  tag_id     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class FilmTaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
