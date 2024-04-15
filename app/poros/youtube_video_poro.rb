class YoutubeVideoPoro
    attr_reader :id,
                :published_at,
                :title,
                :image
  
    def initialize(data)
        @title = data[:snippet][:title]
        @id = data[:id][:videoId]
        @published_at = data[:snippet][:published_at]
        @image = data[:snippet][:thumbnails][:high][:url]
    end
end