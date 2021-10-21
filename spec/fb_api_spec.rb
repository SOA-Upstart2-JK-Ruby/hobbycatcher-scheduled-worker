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
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]

    @page = InfoHunter::FacebookApi.new(FACEBOOK_TOKEN)
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
        InfoHunter::FacebookApi.new(FACEBOOK_TOKEN).page('wrongname', FIELDS)
      end).must_raise InfoHunter::FacebookApi::Errors::BadRequest
    end

    it 'SAD: should raise exception on incorrect fields' do
      _(proc do
        InfoHunter::FacebookApi.new(FACEBOOK_TOKEN).page(PAGENAME, 'wrongfields')
      end).must_raise InfoHunter::FacebookApi::Errors::BadRequest
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        InfoHunter::FacebookApi.new('').page('wrongname', 'wrongfields')
      end).must_raise InfoHunter::FacebookApi::Errors::BadRequest
    end
  end

  describe 'Page Infomation' do
    it 'HAPPY: should provide correct page attributes' do
      _(@page.id).must_equal CORRECT['id']
      _(@page.name).must_equal CORRECT['name']
      _(@page.category).must_equal CORRECT['category']
      _(@page.profile).must_equal CORRECT['profile']
      _(@page.followers).must_equal CORRECT['followers']
      _(@page.rating).must_equal CORRECT['rating']
      _(@page.website).must_equal CORRECT['website']
      _(@page.location).must_equal CORRECT['location']
      _(@page.about).must_equal CORRECT['about']
    end
  end

  describe 'Reviews' do
    it 'HAPPY: should provide correct reviews' do
      reviews = @page.reviews
      _(reviews.count).must_equal CORRECT['reviews']['data'].count

      # sentiments
      sentiments = reviews.map(&:sentiment)
      correct_sentiments = CORRECT['reviews']['data'].map { |c| c['recommendation_type'] }
      _(sentiments).must_equal correct_sentiments
    end
  end

  describe 'Posts' do
    it 'HAPPY: should provide correct posts' do
      posts = @page.posts
      _(posts.count).must_equal CORRECT['posts']['data'].count

      # contents
      contents = posts.map(&:content)
      correct_contents = CORRECT['posts']['data'].map { |c| c['message'] }
      _(contents).must_equal correct_contents
    end
  end
end
