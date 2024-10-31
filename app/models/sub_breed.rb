class SubBreed < ApplicationRecord
  belongs_to :breed

  # checks sub-breed has a name and is unique within the scope of its breed
  validates :name, presence: true, uniqueness: { scope: :breed_id, message: "should be unique within the same breed" }

  # checks sub-breed has an image URL and it's properly formatted as a URL
  validates :image_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }
end
