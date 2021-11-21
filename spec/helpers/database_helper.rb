# frozen_string_literal: true

# Helper to clean database during test runs
# :reek:DuplicateMethodCall
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    HobbyCatcher::App.DB.run('PRAGMA foreign_keys = OFF')
    HobbyCatcher::Database::CourseOrm.map(&:destroy)
    HobbyCatcher::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
