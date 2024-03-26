class UserPoro
    attr_reader :id,
                :name,
                :follows
  
    def initialize(data)
        @id = data[:id]
        @name = data[:name]
        @follows = data[:follows]
    end
end