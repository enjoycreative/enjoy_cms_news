module Enjoy::News
  module Admin
    module Image
      def self.config(nav_label = nil, fields = {})
        if Enjoy::News.config.gallery_support
          if Enjoy::News.mongoid?
            if block_given?
              Enjoy::Gallery::Admin::EmbeddedImage.config(fields) do |config|
                yield config
              end
            else
              Enjoy::Gallery::Admin::EmbeddedImage.config(fields)
            end

          else
            nav_label ||= I18n.t('enjoy.news')
            if block_given?
              Enjoy::Gallery::Admin::Image.config(nav_label, fields) do |config|
                yield config
              end
            else
              Enjoy::Gallery::Admin::Image.config(nav_label, fields)
            end
          end #if Enjoy::News.mongoid?
        end #if Enjoy::News.config.gallery_support

      end #def self.config(fields = {})

    end #module Image
  end #module Admin
end #module Enjoy::News
