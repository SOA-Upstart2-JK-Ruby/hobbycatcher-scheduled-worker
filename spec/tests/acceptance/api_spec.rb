# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/vcr_helper'
require_relative '../../helpers/database_helper'
require 'rack/test'

def app
  HobbyCatcher::App
end
  
describe 'Test API routes' do
  include Rack::Test::Methods
  
  VcrHelper.setup_vcr
  
  before do
    VcrHelper.configure_vcr_for_udemy
    DatabaseHelper.wipe_database
  end
  
  after do
    VcrHelper.eject_vcr
  end
  
  describe 'Get suggestion information' do
    it 'should successfully return project lists' do
      HobbyCatcher::Service::ShowSuggestion.new.call(HOBBY_ID)
      get "/api/v1/suggestion/#{HOBBY_ID}"
      binding.pry
      _(last_response.status).must_equal 200
    end
  end
end
    #     appraisal = JSON.parse last_response.body
    #     _(appraisal.keys.sort).must_equal %w[folder project]
    #     _(appraisal['project']['name']).must_equal PROJECT_NAME
    #     _(appraisal['project']['owner']['username']).must_equal USERNAME
    #     _(appraisal['project']['contributors'].count).must_equal 3
    #     _(appraisal['folder']['path']).must_equal ''
    #     _(appraisal['folder']['subfolders'].count).must_equal 10
    #     _(appraisal['folder']['line_count']).must_equal 1450
    #     _(appraisal['folder']['base_files'].count).must_equal 2
    #   end
  
    #   it 'should be able to appraise a project subfolder' do
    #     CodePraise::Service::AddProject.new.call(
    #       owner_name: USERNAME, project_name: PROJECT_NAME
    #     )
  
    #     get "/api/v1/projects/#{USERNAME}/#{PROJECT_NAME}/spec"
    #     _(last_response.status).must_equal 200
    #     appraisal = JSON.parse last_response.body
    #     _(appraisal.keys.sort).must_equal %w[folder project]
    #     _(appraisal['project']['name']).must_equal PROJECT_NAME
    #     _(appraisal['project']['owner']['username']).must_equal USERNAME
    #     _(appraisal['project']['contributors'].count).must_equal 3
    #     _(appraisal['folder']['path']).must_equal 'spec'
    #     _(appraisal['folder']['subfolders'].count).must_equal 1
    #     _(appraisal['folder']['line_count']).must_equal 151
    #     _(appraisal['folder']['base_files'].count).must_equal 3
    #   end
  
    #   it 'should be report error for an invalid subfolder' do
    #     CodePraise::Service::AddProject.new.call(
    #       owner_name: USERNAME, project_name: PROJECT_NAME
    #     )
  
    #     get "/api/v1/projects/#{USERNAME}/#{PROJECT_NAME}/foobar"
    #     _(last_response.status).must_equal 404
    #     _(JSON.parse(last_response.body)['status']).must_include 'not'
    #   end
  
    #   it 'should be report error for an invalid project' do
    #     CodePraise::Service::AddProject.new.call(
    #       owner_name: '0u9awfh4', project_name: 'q03g49sdflkj'
    #     )
  
    #     get "/api/v1/projects/#{USERNAME}/#{PROJECT_NAME}/foobar"
    #     _(last_response.status).must_equal 404
    #     _(JSON.parse(last_response.body)['status']).must_include 'not'
    #   end
    # end
