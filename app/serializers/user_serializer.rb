class UserSerializer
    include JSONAPI::Serializer

    attributes  :name,
                :follows
end