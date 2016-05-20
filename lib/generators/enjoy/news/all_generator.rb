require 'rails/generators'

module Enjoy::News
  class AllGenerator < Rails::Generators::Base
    argument :class_name, type: :string

    desc 'Enjoy::News generator'
    def all
      generate "enjoy:news:config:install"

      generate "enjoy:news:models:all #{class_name}"

      generate "enjoy:news:controllers:all #{class_name}"
    end

  end
end
