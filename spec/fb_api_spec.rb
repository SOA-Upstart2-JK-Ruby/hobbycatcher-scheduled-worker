# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Tests Facebook API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<FACEBOOK_TOKEN>') { FACEBOOK_TOKEN }
    c.filter_sensitive_data('<FACEBOOK_TOKEN_ESC>') { CGI.escape(FACEBOOK_TOKEN) }
  end

  before do
    VCR.insert_cassette CASSETTE_FB_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]

    @page = HobbyCatcher::FacebookApi.new(FACEBOOK_TOKEN)
                                     .page(PAGENAME, FIELDS)
  end

  after do
    VCR.eject_cassette
  end

  describe 'Page' do
    it 'HAPPY: should provide page' do
      _(@page).wont_be_nil
    end

    it 'SAD: should raise exception on incorrect page name' do
      _(proc do
        HobbyCatcher::FacebookApi.new(FACEBOOK_TOKEN).page('wrongname', FIELDS)
      end).must_raise HobbyCatcher::FacebookApi::Errors::BadRequest
    end

    it 'SAD: should raise exception on incorrect fields' do
      _(proc do
        HobbyCatcher::FacebookApi.new(FACEBOOK_TOKEN).page(PAGENAME, 'wrongfields')
      end).must_raise HobbyCatcher::FacebookApi::Errors::BadRequest
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        HobbyCatcher::FacebookApi.new('').page('wrongname', 'wrongfields')
      end).must_raise HobbyCatcher::FacebookApi::Errors::BadRequest
    end
  end

  describe 'Page Infomation' do
    it 'HAPPY: should provide correct page attributes' do
      _(@page.id).must_equal CORRECT_FB['id']
      _(@page.name).must_equal CORRECT_FB['name']
      _(@page.category).must_equal CORRECT_FB['category']
      _(@page.profile).must_equal CORRECT_FB['profile']
      _(@page.followers).must_equal CORRECT_FB['followers']
      _(@page.rating).must_equal CORRECT_FB['rating']
      _(@page.website).must_equal CORRECT_FB['website']
      _(@page.location).must_equal CORRECT_FB['location']
      _(@page.about).must_equal CORRECT_FB['about']
    end
  end

  describe 'Reviews' do
    it 'HAPPY: should provide correct reviews' do
      reviews = @page.reviews
      _(reviews.count).must_equal CORRECT_FB['reviews']['data'].count

      # review_dates
      review_dates = reviews.map(&:review_date)
      correct_review_dates = CORRECT_FB['reviews']['data'].map { |c| c['created_time'] }
      _(review_dates).must_equal correct_review_dates

      # sentiments
      sentiments = reviews.map(&:sentiment)
      correct_sentiments = CORRECT_FB['reviews']['data'].map { |c| c['recommendation_type'] }
      _(sentiments).must_equal correct_sentiments

      # comments
      comments = reviews.map(&:comment)
      correct_comments = CORRECT_FB['reviews']['data'].map { |c| c['review_text'] }
      _(comments).must_equal correct_comments
    end
  end

  describe 'Posts' do
    it 'HAPPY: should provide correct posts' do
      posts = @page.posts
      _(posts.count).must_equal CORRECT_FB['posts']['data'].count

      # post_ids
      post_ids = posts.map(&:post_id)
      correct_post_ids = CORRECT_FB['posts']['data'].map { |c| c['id'] }
      _(post_ids).must_equal correct_post_ids

      # post_dates
      post_dates = posts.map(&:post_date)
      correct_post_dates = CORRECT_FB['posts']['data'].map { |c| c['date'] }
      _(post_dates).must_equal correct_post_dates

      # contents
      contents = posts.map(&:content)
      correct_contents = CORRECT_FB['posts']['data'].map { |c| c['message'] }
      _(contents).must_equal correct_contents
    end
  end
end
