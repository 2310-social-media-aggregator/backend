require 'rails_helper'

RSpec.describe 'CreatorFacade' do 
    before(:each) do
        # YouTube content creators
        @MrBeast = Creator.create(name: "MrBeast", youtube_handle: 'UCX6OQ3DkcsbYNE6H8uQQuVA')
        @PewDiePie = Creator.create(name: "PewDiePie")
        @Markiplier = Creator.create(name: "Markiplier")
        @jacksepticeye = Creator.create(name: "jacksepticeye")

        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCX6OQ3DkcsbYNE6H8uQQuVA&key=#{Rails.application.credentials.youtube[:key]}&maxResults=5&order=date&part=snippet&q=").
            with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Faraday v2.9.0'
                }).
        to_return(status: 200, body: File.read("spec/fixtures/MrBeastYoutube.json"), headers: {})

        # Twitch content creator
        @zfg = Creator.create(  
                        name: "ZFG",
                        twitch_handle: "8683614"
                    )

        stub_request(:get, "https://api.twitch.tv/helix/videos?first=5&user_id=8683614").
        with(
            headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v2.9.0'
                }
        ).
        to_return(status: 200, body: File.read("spec/fixtures/ZFGTwitch.json"), headers: {})
    end

    it 'aggregates a YouTube creator' do
        package = {
            creator: @MrBeast,
            youtube: YoutubeFacade.get_channel(@MrBeast.youtube_handle),
            twitch: nil,
            twitter: nil
        }

        facade = CreatorFacade.aggregate(package)

        expect(facade.id).to eq(@MrBeast.id)
        expect(facade.name).to eq(@MrBeast.name)

        expect(facade.youtube_videos.count).to be > 1
        expect(facade.youtube_videos[0][:published_at]).to eq("2024-03-19T16:00:00Z")
        expect(facade.youtube_videos[0][:title]).to eq("Keep Track Of Car, Win $10,000")
        expect(facade.youtube_videos[0][:image]).to eq("https://i.ytimg.com/vi/OnTTThIzuNU/hqdefault.jpg")
        expect(facade.youtube_videos[0][:id]).to eq("OnTTThIzuNU")
    end

    it 'aggregates a Twitch creator' do
        package = {
            creator: @zfg,
            youtube: nil,
            twitch: TwitchFacade.get_channel(@zfg.twitch_handle),
            twitter: nil
        }

        facade = CreatorFacade.aggregate(package)

        expect(facade.id).to eq(@zfg.id)
        expect(facade.name).to eq(@zfg.name)

        expect(facade.twitch_videos.count).to be > 1
        expect(facade.twitch_videos[0][:published_at]).to eq("2024-03-24T19:54:27Z")
        expect(facade.twitch_videos[0][:title]).to eq("Majora's Mask Randomizer - No Logic and no starting items")
        expect(facade.twitch_videos[0][:image]).to eq("https://vod-secure.twitch.tv/_404/404_processing_%{width}x%{height}.png")
        expect(facade.twitch_videos[0][:id]).to eq("2100415767")
    end

    it 'index' do
        facade = CreatorFacade.index([@MrBeast,@PewDiePie,@Markiplier,@jacksepticeye])

        expect(facade[:creators][0]).to eq({name: @MrBeast.name,        id: @MrBeast.id})
        expect(facade[:creators][1]).to eq({name: @PewDiePie.name,      id: @PewDiePie.id})
        expect(facade[:creators][2]).to eq({name: @Markiplier.name,     id: @Markiplier.id})
        expect(facade[:creators][3]).to eq({name: @jacksepticeye.name,  id: @jacksepticeye.id})
    end
end