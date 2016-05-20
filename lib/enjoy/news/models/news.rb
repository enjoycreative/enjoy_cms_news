module Enjoy::News
  module Models
    module News
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::HtmlField
      include ManualSlug

      if Enjoy::News.config.seo_support
        include Enjoy::Seo::Seoable
        include Enjoy::Seo::SitemapDataField
      end
      if Enjoy::News.config.pages_support
        include Enjoy::Pages::Connectable
      end
      if Enjoy::News.config.gallery_support
        include Enjoy::Gallery::Paperclipable
      end

      include SmartExcerpt

      include Enjoy::News.orm_specific('News')


      included do

        manual_slug :name

        if Enjoy::News.config.pages_support and Enjoy::News.configuration.can_connect_news_with_pages
          enjoy_connectable_field :connected_pages
        end

        if Enjoy::News.config.gallery_support and Enjoy::News.configuration.news_image_styles
          enjoy_cms_attached_file(:image,
                    styles: lambda { |attachment| attachment.instance.image_styles }
          )
        end

        alias :news_categories :categories

        if Enjoy::News.config.gallery_support
          alias :news_images :images
          accepts_nested_attributes_for :images, allow_destroy: true
        end
      end

      def image_styles
        Enjoy::News.config.news_image_styles
      end

      def image_jcrop_options
        {}
      end
    end
  end
end
