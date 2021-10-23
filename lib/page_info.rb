# frozen_string_literal: true
require_relative 'review'
require_relative 'post'

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
      @reviews ||= @pageinfo['ratings']['data'].map{ |datum| Review.new(datum.to_h)}
      # @reviews ||= @data_source.filter_data(@pageinfo['ratings']['data'],Review)
    end

    def posts
      @posts ||= @pageinfo['posts']['data'].map{ |datum| Post.new(datum.to_h)}
    end
  end
end
