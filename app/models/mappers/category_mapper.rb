# frozen_string_literal: false

module HobbyCatcher
  module Udemy
    # Data Mapper: Udemy course -> Course entity
    class CategoryMapper
      def initialize(ud_token, gateway_class = Udemy::Api)
        @token = ud_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end
  
        # def load_several(url)
        #   @gateway.contributors_data(url).map do |data|
        #     MemberMapper.build_entity(data)
        #   end
        # end
  
        def self.build_entity(data)
          DataMapper.new(data).build_entity
        end
  
        # Extracts entity specific elements from data structure
        class DataMapper
          def initialize(course_name)
            category=HobbyCatcher::Database::CategoryOrm.where(name: course_name).first
            
            @category=category.to_hash
            #binding.pry
          end
  
          def build_entity
            Entity::Category.new(
              id: nil,
              ud_category_id: ud_category_id,
              name: name,
              ownhobby: ownhobby
            )
          end
  
          private
  
          def ud_category_id
            @category[:ud_category_id]
          end
  
          def name
            @category[:name]
          end
  
          def ownhobby
            HobbyMapper.build_entity( @category[:ownhobby_id])

          end
        end
      end
    end
  end