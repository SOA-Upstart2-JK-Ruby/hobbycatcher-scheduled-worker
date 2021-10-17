# frozen_string_literal: true

module InfoHunter
  # Provides access to pageinfo data
  class PageInfo
    def initialize(info_data, data_source)
      @pageinfo = info_data
      @data_source = data_source
    end

    def id
      @pageinfo['id']
    end

    def name
      @pageinfo['name']
    end

    def category
      @pageinfo['category']
    end

    def profile
      @pageinfo['picture']['data']['url']
    end

    def followers
      @pageinfo['followers_count']
    end

    def rating
      @pageinfo['overall_star_rating']
    end

    def website
      @pageinfo['website']
    end

    def location
      @pageinfo['location']
    end

    def about
      [@pageinfo['about'], @pageinfo['description']].join("\n")
    end

    def reviews
      @reviews ||= @data_source.reviews(@pageinfo['ratings']['data'])
    end

    def posts
      @posts ||= @data_source.posts(@pageinfo['posts']['data'])
    end
  end
end
