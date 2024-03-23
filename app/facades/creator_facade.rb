class CreatorFacade
    def self.index(all_creators)
        creators = []
        all_creators.each do |creator|
            creators.append({name: creator.name, id: creator.id})
        end
        {creators: creators}
    end

    def self.aggregate(package)
        youtube_videos = []
        if package[:youtube] != nil
            package[:youtube][:videos].each do |video|
                youtube_videos.append({
                    'id': video.id,
                    'image': video.image,
                    'publishedAt': video.publishedAt,
                    'title': video.title
                })
            end
        end

        {
            id: package[:creator][:id],
            name: package[:creator][:name],
            youtube_videos: youtube_videos,
            twitch: {},
            twitter: {}
        }
    end
end