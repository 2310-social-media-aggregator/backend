# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# users
@user1 = User.create!(
    name: "Thomas the Tank Engine",
    email: "thomas@gmail.com"
    )

# creators
@creator1 = Creator.create!(
    name: "ZFG",
    twitch_handle: "8683614",
    youtube_handle: "UC1qsXgdSxJnQG1wy2Gnvuqw"
    )

@creator2 = Creator.create!(
    name: "Northernlion",
    twitch_handle: "14371185",
    youtube_handle: "UC3tNpTOHsTnkmbwztCs30sA"
    )

@creator3 = Creator.create!(
    name: "Bobbeigh",
    twitch_handle: "25796279",
    youtube_handle: "UCUg7-DV9Cb3Vg-NTKXbL1Ng"
    )

@creator4 = Creator.create!(
    name: "Bawkbasoup",
    twitch_handle: "48533154",
    youtube_handle: "UC1TLG-624t4zkViqiypHoSA"
    )

@creator5 = Creator.create!(
    name: "MickyD",
    twitch_handle: "670977524",
    youtube_handle: "UCEFnMfrd1F3HZFPrzelfNFw"
    )

@creator6 = Creator.create!(
    name: "JupiterClimb",
    twitch_handle: "431401707",
    youtube_handle: "UC7N_E3kqy7cGqjB5a3XX8aQ"
    )

@creator7 = Creator.create!(
    name: "gymnast86",
    twitch_handle: "29418120",
    youtube_handle: "UCJxsAjbKGzdq9__bqTEf_fQ"
    )

@creator8 = Creator.create!(
    name: "CovertMuffin",
    twitch_handle: "36281452",
    youtube_handle: "UChIhmODt32ShmrOLYK7b7pg"
    )

@creator9 = Creator.create!(
    name: "Joseph Anderson",
    twitch_handle: "112295341",
    youtube_handle: "UCyhnYIvIKK_--PiJXCMKxQQ"
    )

@creator10 = Creator.create!(
    name: "Rebelzize",
    twitch_handle: "38586896",
    youtube_handle: "UCZeO7KWB8iYmhnKB53oY3pw"
    )

@creator11 = Creator.create!(
  name: "Aztecross",
  twitch_handle: "50881182",
  youtube_handle: "UClbllR4TxlhYJyrpu1sA4A")

# follows
@follow1 = @user1.follows.create!(creator_id: @creator1.id)
@follow2 = @user1.follows.create!(creator_id: @creator2.id)
@follow3 = @user1.follows.create!(creator_id: @creator3.id)
@follow4 = @user1.follows.create!(creator_id: @creator4.id)
@follow5 = @user1.follows.create!(creator_id: @creator5.id)

