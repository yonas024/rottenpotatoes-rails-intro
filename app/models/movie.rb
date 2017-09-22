class Movie < ActiveRecord::Base
    
    def self.get_ratings
        set = Set.new
        for m in Movie.select("rating")
            set.add(m.rating)
        end 
        return set
        
    end
end
