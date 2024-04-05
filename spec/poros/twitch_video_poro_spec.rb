require 'rails_helper'

RSpec.describe TwitchVideoPoro do
    it 'creates an Twitch Video Poro based on attributes' do
        attr = {
            "id": "2100415767",
            "stream_id": "42444153433",
            "user_id": "8683614",
            "user_login": "zfg1",
            "user_name": "Zfg1",
            "title": "Majora's Mask Randomizer - No Logic and no starting items",
            "description": "",
            "created_at": "2024-03-24T19:54:27Z",
            "published_at": "2024-03-24T19:54:27Z",
            "url": "https://www.twitch.tv/videos/2100415767",
            "thumbnail_url": "https://vod-secure.twitch.tv/_404/404_processing_%{width}x%{height}.png",
            "viewable": "public",
            "view_count": 108,
            "language": "en",
            "type": "archive",
            "duration": "4h42m52s",
            "muted_segments": nil
        }

        video = TwitchVideoPoro.new(attr)
        expect(video).to be_a(TwitchVideoPoro)
        expect(video.published_at).to eq("2024-03-24T19:54:27Z")
        expect(video.title).to eq("Majora's Mask Randomizer - No Logic and no starting items")
        expect(video.image).to eq("https://vod-secure.twitch.tv/_404/404_processing_%{width}x%{height}.png")
        expect(video.id).to eq("2100415767")
    end
end