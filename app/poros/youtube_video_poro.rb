class YoutubeVideoPoro
    attr_reader :id,
                :publishedAt,
                :title,
                :image
  
    def initialize(data)
        @title = data[:snippet][:title]
        @id = data[:id][:videoId]
        @publishedAt = data[:snippet][:publishedAt]
        @image = data[:snippet][:thumbnails][:high][:url]
    end
end