# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/database_helper'
require_relative '../../helpers/vcr_helper'

require 'headless'
require 'webdrivers/chromedriver'
require 'webdrivers'
require 'watir'

describe 'Acceptance Tests' do
  before do
    # DatabaseHelper.wipe_database
    # @headless = Headless.new
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    @browser = Watir::Browser.new :chrome, :options => options
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Homepage' do
    describe 'Visit Home page' do
      it '(HAPPY) should see two buttons' do
        # GIVEN: user is on the home page without any projects
        @browser.goto homepage 
        _(@browser.title).must_equal 'HobbyCatcher'
        _(@browser.button(id: 'hobby-form-submit-test').present?).must_equal true
      end
    end
    describe 'Visit catch my hobby' do
      it '(HAPPY) redirect to test page' do
        @browser.goto homepage 
        # binding.pry
      
        @browser.button(id: 'hobby-form-submit-test').click
        
         # # THEN: they should find themselves on the test's page
        @browser.url.include? 'test'
      end
    end
  end
  
  describe 'Test page' do
    describe 'see the test question' do
      
      it '(HAPPY) see the answer radio' do
        
        @browser.goto homepage 
        @browser.button(id: 'hobby-form-submit-test').click

        _(@browser.radio(id: 'type1').present?).must_equal true
        _(@browser.radio(id: 'difficulty1').present?).must_equal true
        _(@browser.radio(id: 'freetime1').present?).must_equal true
        _(@browser.radio(id: 'emotion1').present?).must_equal true

      end


      it '(HAPPY) redirect to the right suggestion' do
        
        @browser.goto homepage 
        @browser.button(id: 'hobby-form-submit-test').click

        @browser.radio(id: 'type1').click
        @browser.radio(id: 'difficulty1').click
        @browser.radio(id: 'freetime1').click
        @browser.radio(id: 'emotion1').click

        @browser.button(id: 'hobby-form-submit-question').click

        @browser.url.include? 'suggestion/1'
        
      end
    end
  end

  describe 'Suggestion page' do
    it '(HAPPY) suggest right hobby' do

      @browser.goto homepage 
      @browser.button(id: 'hobby-form-submit-test').click

      @browser.radio(id: 'type1').click
      @browser.radio(id: 'difficulty1').click
      @browser.radio(id: 'freetime1').click
      @browser.radio(id: 'emotion1').click

      @browser.button(id: 'hobby-form-submit-question').click

      (@browser.h5(id: 'hobby_name').text).must_equal 'LION'
      (@browser.h5(id: 'Dance').present?).must_equal true
    end
  end
      

end
