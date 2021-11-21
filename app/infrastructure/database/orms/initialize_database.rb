# frozen_string_literal: true

HOBBY_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/hobby.yml'))
CATEGORY_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/category.yml'))
QUESTION_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/question.yml'))


module HobbyCatcher
  module InitializeDatabase
    # InitializeDatabase for Create Question, Hobby & Category
    class Create
<<<<<<< HEAD
      def self.load
        HOBBY_FILE.map do |data|
=======
      def self.hobby_load
        HOBBY_FILE.map do |data| 
>>>>>>> 1bc08d5f7e5f11f57073d45d8298169b70b7bda6
          Database::HobbyOrm.create(data)
        end

        CATEGORY_FILE.map do |data|
          Database::CategoryOrm.create(data)
        end

        QUESTION_FILE.map do |data|
          Database::QuestionOrm.create(data)
        end
      end
    end
  end
end
