module Enjoy::News
  module Models
    module Mongoid
      module Image
        extend ActiveSupport::Concern
        if Enjoy::News.config.gallery_support

          included do
            embedded_in :news, class_name: "Enjoy::News::News"
          end

          include ::Mongoid::EmbeddedFindable
          module ClassMethods
            def find(id)
              find_through(Enjoy::News::News, 'images', id)
            end
          end
        end
      end
    end
  end
end
