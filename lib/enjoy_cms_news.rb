unless defined?(Enjoy) && Enjoy.respond_to?(:orm) && [:active_record, :mongoid].include?(Enjoy.orm)
  puts "please use enjoy_cms_mongoid or enjoy_cms_activerecord"
  puts "also: please use enjoy_cms_news_mongoid or enjoy_cms_news_activerecord and not enjoy_cms_news directly"
  exit 1
end

require "enjoy/news/version"
require 'enjoy/news/engine'
require 'enjoy/news/configuration'

require 'enjoy/news/routes'
require 'enjoy/news/admin'

require 'smart_excerpt'

# require 'enjoy_cms_pages'   if Enjoy::News.config.pages_support
# require 'enjoy_cms_seo'     if Enjoy::News.config.seo_support
# require 'enjoy_cms_gallery' if Enjoy::News.config.gallery_support

module Enjoy::News
  class << self
    def orm
      Enjoy.orm
    end
    def mongoid?
      Enjoy::News.orm == :mongoid
    end
    def active_record?
      Enjoy::News.orm == :active_record
    end
    def model_namespace
      "Enjoy::News::Models::#{Enjoy::News.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

  autoload :Admin,  'enjoy/news/admin'
  module Admin
    autoload :News,       'enjoy/news/admin/news'
    autoload :Category,   'enjoy/news/admin/category'
    autoload :Image,      'enjoy/news/admin/image'
  end

  module Models
    autoload :News,       'enjoy/news/models/news'
    autoload :Category,   'enjoy/news/models/category'
    autoload :Image,      'enjoy/news/models/image'

    module Mongoid
      autoload :News,       'enjoy/news/models/mongoid/news'
      autoload :Category,   'enjoy/news/models/mongoid/category'
      autoload :Image,      'enjoy/news/models/mongoid/image'
    end

    module ActiveRecord
      autoload :News,       'enjoy/news/models/active_record/news'
      autoload :Category,   'enjoy/news/models/active_record/category'
      autoload :Image,      'enjoy/news/models/active_record/image'
    end
  end

  module Controllers
    autoload :Items,            'enjoy/news/controllers/news'
    autoload :Categories,       'enjoy/news/controllers/categories'
  end

end
