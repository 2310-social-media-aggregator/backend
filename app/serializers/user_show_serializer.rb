class UserShowSerializer
    include JSONAPI::Serializer
  
    set_id { nil }
    attribute :name do |object|
        object[:name]
    end

    attribute :follows do |object|
        object[:follows]
    end
end