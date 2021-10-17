module InfoHunter
  # Provides access to post data
  class Post
    def initialize(post_data)
      @post = post_data
    end

    def post_id
      @post['id']
    end

    def post_date
      @post['date']
    end

    def content
      @post['message']
    end
  end
end