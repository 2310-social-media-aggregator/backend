class UserFacade

    def self.show(user)
        follows = []
        user.follows.each do |follow|
            creator = Creator.find_by(id: follow.creator_id)
            if creator != nil
                follows.append({id: creator.id, name: creator.name})
            # else
            #     follow.destroy ## We don't think this is necessary or possible, but keeping this here in case we need it
            end
        end

        UserPoro.new({
            'id': user.id,
            'name': user.name,
            'follows': follows
        })
    end

end