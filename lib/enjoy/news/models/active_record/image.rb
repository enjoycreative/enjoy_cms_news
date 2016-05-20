module Enjoy::News
  module Models
    module Mongoid
      module Image
        extend ActiveSupport::Concern
        if Enjoy::News.config.gallery_support
          included do
            belongs_to :enjoy_gallery_imagable, class_name: 'Enjoy::News::News'

            validates_lengths_from_database only: [:name]
          end
        end
      end
    end
  end
end
