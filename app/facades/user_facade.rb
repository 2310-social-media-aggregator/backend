class UserFacade

    def self.show(user)
        follows = []
        user.follows.each do |follow|
            creator = Creator.find_by(id: follow.creator_id)
            if creator != nil
                follows.append({id: creator.id, name: creator.name})
            else
                follow.destroy
            end
        end

        UserPoro.new({
            'id': user.id,
            'name': user.name,
            'follows': follows
        })
    end

end