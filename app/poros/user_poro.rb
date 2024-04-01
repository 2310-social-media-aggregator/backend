class UserPoro
    attr_reader :id,
                :name,
                :follows,
                :email
  
    def initialize(data)
        @id = data[:id]
        @name = data[:name]
        @follows = data[:follows]
        @email = data[:email]
    end
end