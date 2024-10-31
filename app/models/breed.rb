class Breed < ApplicationRecord
  has_many :sub_breeds

  # if the breed has a name and it is unique
  validates :name, presence: true, uniqueness: true

  # if the breed has an image URL and it's properly formatted as a URL by using a regular expression
  validates :image_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }
end
