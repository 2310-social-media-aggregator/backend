class TwitchVideoPoro
    attr_reader :id,
                :published_at,
                :title,
                :image

    def initialize(data)
        @id = data[:id]
        @title = data[:title]
        @published_at = data[:published_at]
        @image = data[:thumbnail_url]
    end
end
