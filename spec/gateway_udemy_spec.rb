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
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
    @course = HobbyCatcher::Udemy::CourseMapper.new(UDEMY_TOKEN)
                                               .find(COURSEID)
  end

  after do
    VCR.eject_cassette
  end

  describe 'Course' do
    it 'HAPPY: should provide course' do
      _(@course).wont_be_nil
    end

    it 'SAD: should raise exception on incorrect course' do
      _(proc do
        HobbyCatcher::Udemy::CourseMapper.new(UDEMY_TOKEN).find('wrongid')
      end).must_raise HobbyCatcher::Udemy::Api::Response::NotFound
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        HobbyCatcher::Udemy::CourseMapper.new('WrongToken').find('')
      end).must_raise HobbyCatcher::Udemy::Api::Response::Forbidden
    end
  end

  describe 'Course Infomation' do
    it 'HAPPY: should provide correct course attributes' do
      _(@course.id).must_equal CORRECT_UD['id']
      _(@course.title).must_equal CORRECT_UD['title']
      _(@course.url).must_equal CORRECT_UD['url']
      _(@course.price).must_equal CORRECT_UD['price']
      _(@course.image).must_equal CORRECT_UD['image']
    end
  end

  describe 'Reviews' do
    it 'HAPPY: should provide correct reviews' do
      reviews = @course.reviews
      _(reviews.count).must_equal CORRECT_UD['reviews'].count

      # review_dates
      dates = reviews.map(&:date)
      correct_dates = CORRECT_UD['reviews'].map { |c| c['date'] }
      _(dates).must_equal correct_dates

      # rating
      ratings = reviews.map(&:rating)
      correct_ratings = CORRECT_UD['reviews'].map { |c| c['rating'] }
      _(ratings).must_equal correct_ratings

      # content
      contents = reviews.map(&:content)
      correct_contents = CORRECT_UD['reviews'].map { |c| c['content'] }
      _(contents).must_equal correct_contents
    end
  end
end
