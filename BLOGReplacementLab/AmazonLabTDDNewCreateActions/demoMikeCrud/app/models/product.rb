# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  price       :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
 validates :title, presence: true, uniqueness: true
 validates :price, presence: true, uniqueness: true


end
