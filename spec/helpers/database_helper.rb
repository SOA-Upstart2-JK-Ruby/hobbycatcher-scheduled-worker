# frozen_string_literal: true

require_relative '../../init'

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    HobbyCatcher::App.DB.run('PRAGMA foreign_keys = OFF')
    HobbyCatcher::Database::CourseOrm.map(&:destroy)
    HobbyCatcher::Database::CourselistOrm.map(&:destroy)
    HobbyCatcher::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
