class CreatorIndexSerializer
    include JSONAPI::Serializer
    set_id { nil }

    attribute :creators do |object|
        object[:creators]
    end
end