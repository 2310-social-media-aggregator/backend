require 'rails_helper'

RSpec.describe YoutubeVideoPoro do
    it 'creates an Youtube Video Poro based on attributes' do
        attr = {
            "kind": "youtube#searchResult",
            "etag": "Ptt38qLNXSKnbr_UJwionXkXDOI",
            "id": {
                "kind": "youtube#video",
                "videoId": "mKdjycj-7eE"
            },
            "snippet": {
                "publishedAt": "2024-03-16T16:00:00Z",
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

        video = YoutubeVideoPoro.new(attr)
        expect(video).to be_a(YoutubeVideoPoro)
        expect(video.publishedAt).to eq("2024-03-16T16:00:00Z")
        expect(video.title).to eq("Stop This Train, Win a Lamborghini")
        expect(video.image).to eq("https://i.ytimg.com/vi/mKdjycj-7eE/hqdefault.jpg")
        expect(video.id).to eq("mKdjycj-7eE")
    end
end