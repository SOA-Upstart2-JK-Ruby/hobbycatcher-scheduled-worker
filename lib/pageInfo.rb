module InfoHunter
  # Provides access to pageInfo data
  class PageInfo
    def initialize(info_data)
      @pageInfo = info_data
    end
  
    def id
      @pageInfo['id']
    end
      
    def name
      @pageInfo['name']
    end
      
    def category
      @pageInfo['category']
    end
  
    def profile
      @pageInfo['picture']['data']['url']
    end
  
    def followers
      @pageInfo['followers_count']
    end
  
    def rating
      @pageInfo['overall_star_rating']
    end
  
    def website
      @pageInfo['website']
    end
  
    def location
      @pageInfo['location']
    end
  
    def about
      @pageInfo['about'] + "\n" + @pageInfo['description']
    end
  end
end