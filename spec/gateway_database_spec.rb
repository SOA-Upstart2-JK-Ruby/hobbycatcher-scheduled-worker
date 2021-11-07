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
      data = HobbyCatcher::Udemy::CourselistMapper
                .new(UDEMY_TOKEN)
                .find('category', hobby)
        #.find(USERNAME, PROJECT_NAME)
        
        courses = data.to_hash[:courses]
        courses.map { |course|
          rebuilt =Database::CourseOrm.create(course.reject { |key, _| [:id].include? key })
          _(rebuilt.course_id).must_equal(course.course_id)
          _(rebuilt.title).must_equal(course.title)
          _(rebuilt.url).must_equal(course.url)
          _(rebuilt.price).must_equal(course.price)
          _(rebuilt.image).must_equal(course.image)
          _(rebuilt.rating).must_equal(course.rating)
        }
        
    #   rebuilt = CodePraise::Repository::For.entity(project).create(project)

    #   _(rebuilt.origin_id).must_equal(project.origin_id)
    #   _(rebuilt.name).must_equal(project.name)
    #   _(rebuilt.size).must_equal(project.size)
    #   _(rebuilt.ssh_url).must_equal(project.ssh_url)
    #   _(rebuilt.http_url).must_equal(project.http_url)
    #   _(rebuilt.contributors.count).must_equal(project.contributors.count)

    #   project.contributors.each do |member|
    #     found = rebuilt.contributors.find do |potential|
    #       potential.origin_id == member.origin_id
    #     end

    #     _(found.username).must_equal member.username
        # not checking email as it is not always provided
    #   end
    end
  end
end