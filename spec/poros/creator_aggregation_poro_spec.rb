require 'rails_helper'

RSpec.describe CreatorAggregationPoro do
    before :each do
        @youtube_poro = YoutubeVideoPoro.new(
            {
            "kind": "youtube#searchResult",
            "etag": "Ptt38qLNXSKnbr_UJwionXkXDOI",
            "id": {
                "kind": "youtube#video",
                "videoId": "mKdjycj-7eE"
            },
            "snippet": {
                "published_at": "2024-03-16T16:00:00Z",
                "channelId": "UCX6OQ3DkcsbYNE6H8uQQuVA",
                "title": "Stop This Train, Win a Lamborghini",
                "description": "I still can't believe what happened in this video lol Check out the mind-blowing Galaxy AI on the Samsung Galaxy S24 Ultra.",
                "thumbnails": {
                    "default": {
                        "url": "https://i.ytimg.com/vi/mKdjycj-7eE/default.jpg",
                        "width": 120,
                        "height": 90
                    },
                    "medium": {
                        "url": "https://i.ytimg.com/vi/mKdjycj-7eE/mqdefault.jpg",
                        "width": 320,
                        "height": 180
                    },
                    "high": {
                        "url": "https://i.ytimg.com/vi/mKdjycj-7eE/hqdefault.jpg",
                        "width": 480,
                        "height": 360
                    }
                },
                "channelTitle": "MrBeast",
                "liveBroadcastContent": "none",
                "publishTime": "2024-03-16T16:00:00Z"
            }
        }
        )

        @twitch_poro = TwitchVideoPoro.new(
            {
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
        )
        
        @attributes = {
            id: 21,
            name: "Parsnip O'Houlahan",
            youtube_videos: [@youtube_poro],
            twitch_videos: [@twitch_poro]
        }
    end

    it 'creates a Creator Aggregation Poro based on attributes' do
        poro = CreatorAggregationPoro.new(@attributes)

        expect(poro).to be_a(CreatorAggregationPoro)

        expect(poro.id).to be_a Integer
        expect(poro.name).to be_a String
        expect(poro.youtube_videos).to be_a Array
        expect(poro.youtube_videos[0]).to be_a YoutubeVideoPoro
        expect(poro.twitch_videos).to be_a Array
        expect(poro.twitch_videos[0]).to be_a TwitchVideoPoro

        expect(poro.id).to eq(21)
        expect(poro.name).to eq("Parsnip O'Houlahan")
        expect(poro.youtube_videos.count).to eq(1)
        expect(poro.twitch_videos.count).to eq(1)
    end
end