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
  describe 'Page Infomation' do
    it 'HAPPY: should provide correct page attributes' do
      page = InfoHunter::FacebookApi.new(FACEBOOK_TOKEN)
                                    .pageInfo(PAGENAME, FIELDS) #consider what kind of data we need
      _(page.id).must_equal CORRECT['id']
      _(page.name).must_equal CORRECT['name']
      _(page.category).must_equal CORRECT['category']
      _(page.profile).must_equal CORRECT['profile']
      _(page.followers).must_equal CORRECT['followers']
      _(page.rating).must_equal CORRECT['rating']
      _(page.website).must_equal CORRECT['website']
      _(page.location).must_equal CORRECT['location']
      _(page.about).must_equal CORRECT['about']
    end

    it 'SAD: should raise exception on incorrect page name' do
      _(proc do
        InfoHunter::FacebookApi.new(FACEBOOK_TOKEN).project('wrongname', 'wrongfields')
      end).must_raise InfoHunter::FacebookApi::Errors::NotFound
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        InfoHunter::FacebookApi.new('BAD_TOKEN').project('wrongname', 'wrongfields')
      end).must_raise InfoHunter::FacebookApi::Errors::Unauthorized
    end
  end

  describe 'Reviews' do
    before do
      @page = InfoHunter::FacebookApi.new(FACEBOOK_TOKEN)
                                        .pageInfo(PAGENAME, FIELDS)
    end

    it 'HAPPY: should provide correct review attributes' do
      _(@page.review).must_be_kind_of InfoHunter::Reviews #review只做個別review存取
    end

    it 'HAPPY: should identify reviews' do
      reviews = @page.reviews
      _(reviews.count).must_equal CORRECT['reviews']['data'].count

      _(reviews.sentiment).must_equal CORRECT['reviews']['data']['recommendation_type']
    end
  end
end


