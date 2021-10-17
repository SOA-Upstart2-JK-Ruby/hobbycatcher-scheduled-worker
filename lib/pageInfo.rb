module InfoHunter
  # Provides access to pageInfo data
  class PageInfo
    def initialize(info_data, data_source)
      @pageInfo = info_data
      @data_source = data_source
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

    def reviews
      #binding.pry
      @reviews ||= @data_source.reviews(@pageInfo['ratings']['data'])
    end

    def posts
      #binding.pry
      @posts ||= @data_source.posts(@pageInfo['posts']['data'])
    end
  end
end
