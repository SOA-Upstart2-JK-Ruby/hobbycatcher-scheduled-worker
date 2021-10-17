# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/fb_api'

PAGENAME = 'tahrd108'
FIELDS = %w[id name category picture followers_count overall_star_rating website location
            about description ratings posts].join('%2C')
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
FACEBOOK_TOKEN = CONFIG['FACEBOOK_TOKEN']
CORRECT = YAML.safe_load(File.read('spec/fixtures/facebook_results.yml'))

describe 'Tests Facebook API library' do
  before do
    @page = InfoHunter::FacebookApi.new(FACEBOOK_TOKEN)
                                      .page(PAGENAME, FIELDS)
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
