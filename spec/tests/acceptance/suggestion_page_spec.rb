# frozen_string_literal: true

require_relative '../../helpers/acceptance_helper'
require_relative 'pages/home_page'
require_relative 'pages/test_page'

describe 'Suggestion Page Acceptance Tests' do
  include PageObject::PageFactory

  before do
    DatabaseHelper.wipe_database
    # Headless error? https://github.com/leonid-shevtsov/headless/issues/80
    # @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Visit Suggestion page' do
    it '(HAPPY) should see what kind of animal the user is' do
      # WHEN: user visit the suggestion page
      visit SuggestionPage do |page|
        # THEN: they should see hobby suggestion based on the test result
        _(page.hobby_name).must_equal 'HobbyCatcher'
        _(page.text_content.present?).must_equal true
        _(page.text_content.present?).must_equal true
        _(page.try_again_element.present?).must_equal true

        # _(page.success_message_element.present?).must_equal true
        # _(page.success_message.downcase).must_include 'start'
      end
    end

    it '(HAPPY) suggest right hobby' do
      # GIVEN: user has taken the test and answer the questions with the answers
      visit HomePage do |page|
        page.catch_hobby
      end

      visit TestPage do |page|
        page.see_result
      end
      @browser.button(id: 'hobby-form-submit-test').click
      @browser.radio(id: 'type1').click
      @browser.radio(id: 'difficulty1').click
      @browser.radio(id: 'freetime1').click
      @browser.radio(id: 'emotion1').click
      @browser.button(id: 'hobby-form-submit-question').click
      
      # WHEN: user visit the suggestion page
      visit SuggestionPage do |page|
        # THEN: they should see hobby suggestion of Lion
        _(page.hobby_name).must_equal 'LION'
        _(page.category_name).must_equal 'Dance'
      end
    end
  end

  describe 'Click try again' do
    it '(HAPPY) redirect to home page' do
      # WHEN: user click the button
      page.try_again
      # THEN: they should find themselves on the home page
      @browser.goto homepage
    end
  end
end