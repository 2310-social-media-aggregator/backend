class UserSerializer
    include JSONAPI::Serializer

    attributes  :name,
                :follows,
                :email
end