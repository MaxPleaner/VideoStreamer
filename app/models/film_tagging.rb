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
class FilmTagging < ApplicationRecord
  belongs_to :film
  belongs_to :tag
end
