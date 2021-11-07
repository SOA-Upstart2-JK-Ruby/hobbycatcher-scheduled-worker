# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Tests Udemy API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<UDEMY_TOKEN>') { UDEMY_TOKEN }
    c.filter_sensitive_data('<UDEMY_TOKEN_ESC>') { CGI.escape(UDEMY_TOKEN) }
  end

  before do
    VCR.insert_cassette CASSETTE_UD_FILE,
                        record:            :new_episodes,
                        match_requests_on: %i[method uri headers]
    @courselist = HobbyCatcher::Udemy::CourselistMapper.new(UDEMY_TOKEN)
      .find(FIELD, KEYWORD)
  end

  after do
    VCR.eject_cassette
  end

  describe 'Courselist' do
    it 'HAPPY: should provide courselist' do
      _(@courselist).wont_be_nil
    end

    # it 'SAD: should raise exception on incorrect course' do
    #   _(proc do
    #     HobbyCatcher::Udemy::CourselistMapper.new(UDEMY_TOKEN).find('wrongfield', 'wrongkeyword')
    #   end).must_raise HobbyCatcher::Udemy::Api::Response::NotFound
    # end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        HobbyCatcher::Udemy::CourselistMapper.new('WrongToken')
                                            .find(FIELD, KEYWORD)
      end).must_raise HobbyCatcher::Udemy::Api::Response::Forbidden
    end
  end

  describe 'Course Infomation' do
    it 'HAPPY: should provide correct course attributes' do
      courses = @courselist.courses
      _(courses.count).must_equal CORRECT_UD['courses'].count

      # course_id
      ids = courses.map(&:course_id)
      correct_ids = CORRECT_UD['courses'].map { |c| c['id'] }
      _(ids).must_equal correct_ids

      # title
      titles = courses.map(&:title)
      correct_titles = CORRECT_UD['courses'].map { |c| c['title'] }
      _(titles).must_equal correct_titles

      # url
      urls = courses.map(&:url)
      correct_urls = CORRECT_UD['courses'].map { |c| c['url'] }
      _(urls).must_equal correct_urls

      # price
      prices = courses.map(&:price)
      correct_prices = CORRECT_UD['courses'].map { |c| c['price'] }
      _(prices).must_equal correct_prices

      # image
      images = courses.map(&:image)
      correct_images = CORRECT_UD['courses'].map { |c| c['image'] }
      _(images).must_equal correct_images

      # rating
      ratings = courses.map(&:rating)
      correct_ratings = CORRECT_UD['courses'].map { |c| c['rating'] }
      _(ratings).must_equal correct_ratings
    end
  end
end
