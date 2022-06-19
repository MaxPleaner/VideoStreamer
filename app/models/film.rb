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
end
