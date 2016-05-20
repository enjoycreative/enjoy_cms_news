require 'rails/generators'

module Enjoy::News::Models
  class CategoryGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name, type: :string
    argument :news_class_name_arg, type: :string, default: ""

    desc 'Enjoy::News Category Model generator'
    def category
      template 'category.erb', "app/models/#{file_name}.rb"
    end

    private
    def capitalized_class_name
      class_name.capitalize
    end

    def camelcased_class_name
      class_name.camelcase
    end

    def file_name
      underscored_class_name
    end

    def underscored_class_name
      camelcased_class_name.underscore
    end

    def underscored_pluralized_class_name
      underscored_class_name.pluralize
    end

    def news_class_name
      news_class_name_arg.blank? ? camelcased_class_name.sub(/Category$/, "") : news_class_name_arg
    end
  end
end
