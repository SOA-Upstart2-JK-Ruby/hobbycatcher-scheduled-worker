# frozen_string_literal: false

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Udemy API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_udemy
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store project' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save project from Github to database' do
      data = HobbyCatcher::Udemy::CourselistMapper.new(UDEMY_TOKEN)
        .find(FIELD, KEYWORD)
      courses = data.to_hash[:courses]
      courses.map do |course|
        rebuilt = HobbyCatcher::Database::CourseOrm.create(course.reject { |key, _| [:id].include? key })
        _(rebuilt[:course_id]).must_equal(course[:course_id])
        _(rebuilt[:title]).must_equal(course[:title])
        _(rebuilt[:url]).must_equal(course[:url])
        _(rebuilt[:price]).must_equal(course[:price])
        _(rebuilt[:image]).must_equal(course[:image])
        _(rebuilt[:rating]).must_equal(course[:rating])
      end
    end
  end
end
