# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
@zfg = Creator.create(  name: "ZFG",
                        twitch_handle: "8683614",
                        youtube_handle: "UC1qsXgdSxJnQG1wy2Gnvuqw")

user_1 = User.create!( name: "Thomas the Tank Engine",
                        email: "thomas@gmail.com")