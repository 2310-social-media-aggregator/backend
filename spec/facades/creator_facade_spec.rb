require 'rails_helper'

RSpec.describe 'CreatorFacade' do 
    before(:each) do
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
    end

    it 'aggregate' do
        package = {
            creator: @MrBeast,
            youtube: YoutubeFacade.get_channel(@MrBeast.youtube_handle, nil),
            twitch: nil,
            twitter: nil
        }

        facade = CreatorFacade.aggregate(package)

        expect(facade[:id]).to eq(@MrBeast.id)
        expect(facade[:name]).to eq(@MrBeast.name)

        expect(facade[:youtube_videos].count).to be > 1
        expect(facade[:youtube_videos][0][:publishedAt]).to eq("2024-03-19T16:00:00Z")
        expect(facade[:youtube_videos][0][:title]).to eq("Keep Track Of Car, Win $10,000")
        expect(facade[:youtube_videos][0][:image]).to eq("https://i.ytimg.com/vi/OnTTThIzuNU/hqdefault.jpg")
        expect(facade[:youtube_videos][0][:id]).to eq("OnTTThIzuNU")

        # Twitch facade test set to nil since Twitch consumption is complete; revisit test with creator on both YouTube and Twitch as more robust example, since we'll have Twitch video data as well
        expect(facade[:twitch]).to eq(nil)
        expect(facade[:twitter]).to eq({})
    end

    it 'index' do
        facade = CreatorFacade.index([@MrBeast,@PewDiePie,@Markiplier,@jacksepticeye])

        expect(facade[:creators][0]).to eq({name: @MrBeast.name,        id: @MrBeast.id})
        expect(facade[:creators][1]).to eq({name: @PewDiePie.name,      id: @PewDiePie.id})
        expect(facade[:creators][2]).to eq({name: @Markiplier.name,     id: @Markiplier.id})
        expect(facade[:creators][3]).to eq({name: @jacksepticeye.name,  id: @jacksepticeye.id})
    end
end