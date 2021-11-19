# frozen_string_literal: true

HOBBY_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/hobby.yml'))
CATEGORY_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/category.yml'))

module HobbyCatcher
  module InitializeDatabase
    # InitializeDatabase for Create Hobby & Category
    class Create
      def self.hobby_load
        HOBBY_FILE.map do |data| 
          Database::HobbyOrm.create(data)
        end
      end
      def self.category_load
        CATEGORY_FILE.map do |data|
          Database::CategoryOrm.create(data)
        end
      end
    end
  end
end
