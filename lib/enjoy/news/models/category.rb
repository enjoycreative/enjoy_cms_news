module Enjoy::News
  module Models
    module Category
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


      include Enjoy::News.orm_specific('Category')

      include ManualSlug

      included do
        if defined?(RailsAdminComments)
          include RailsAdminComments::Commentable
        end
        manual_slug :name

        if Enjoy::News.config.gallery_support and Enjoy::News.configuration.category_image_styles
          enjoy_cms_attached_file(:image)
        end

        acts_as_nested_set

        if Enjoy::News.config.pages_support and Enjoy::News.configuration.can_connect_category_with_pages
          enjoy_connectable_field :connected_pages
        end
      end

      def news_class
        Enjoy::News::News
      end

      def image_styles
        Enjoy::News.configuration.category_image_styles
      end

      def page_title
      end

    end
  end
end
