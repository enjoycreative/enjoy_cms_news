module Enjoy
  module News
    def self.configuration
      @configuration ||= Configuration.new
    end
    def self.config
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    class Configuration
      attr_accessor :news_image_styles
      attr_accessor :category_image_styles
      attr_accessor :images_image_styles

      attr_accessor :news_per_page
      attr_accessor :news_excerpt
      attr_accessor :news_content_required

      attr_accessor :gallery_support
      attr_accessor :seo_support
      attr_accessor :pages_support

      attr_accessor :can_connect_news_with_pages
      attr_accessor :can_connect_category_with_pages

      attr_accessor :localize

      def initialize
        @news_image_styles = {
            main:  '400x200>',
            thumb: '200x100>'
        }
        @category_image_styles = {
            main:  '400x200>',
            thumb: '200x100>'
        }
        @images_image_styles = {
            main:  '400x200>',
            thumb: '200x100>'
        }

        @news_per_page = 10
        @news_excerpt = 12
        @news_content_required = true

        @gallery_support = defined? Enjoy::Gallery
        @seo_support = defined? Enjoy::Seo
        @pages_support = defined? Enjoy::Pages

        @can_connect_news_with_pages = true
        @can_connect_category_with_pages = true

        @localize = Enjoy.config.localize
      end
    end
  end
end
