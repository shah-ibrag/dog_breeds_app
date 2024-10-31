# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'net/http'
require 'json'

def fetch_json(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

puts "Fetching breeds list..."
breeds_response = fetch_json('https://dog.ceo/api/breeds/list/all')
breeds_data = breeds_response['message']

breeds_data.each do |breed_name, sub_breeds|
  next if sub_breeds.empty?
  puts "Processing breed: #{breed_name}"

  breed_image_response = fetch_json("https://dog.ceo/api/breed/#{breed_name}/images/random")
  breed_image = breed_image_response['message']
  
  breed = Breed.create(name: breed_name, image_url: breed_image)
  puts "Breed created: #{breed.name} with image URL: #{breed.image_url}"

  sub_breeds.each do |sub_breed_name|
    puts "Processing sub-breed: #{sub_breed_name} of #{breed_name}"
    sub_breed_image_response = fetch_json("https://dog.ceo/api/breed/#{breed_name}/#{sub_breed_name}/images/random")
    sub_breed_image = sub_breed_image_response['message']
    
    sub_breed = breed.sub_breeds.create(name: sub_breed_name, image_url: sub_breed_image)
    puts "Sub-breed created: #{sub_breed.name} with image URL: #{sub_breed.image_url}"
  end
end

puts "Seeding completed."
