require 'rails/generators'

module Enjoy::News::Config
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy::News Config generator'
    def install
      template 'enjoy_news.erb', "config/initializers/enjoy_news.rb"
    end

  end
end
