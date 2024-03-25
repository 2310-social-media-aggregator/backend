class UserFacade

    def self.show(user)
        follows = []
        user.follows.each do |follow|
            follows.append({name: follow.name})
        end

        {
            'name': user.name,
            'follows': follows
        }
    end

end