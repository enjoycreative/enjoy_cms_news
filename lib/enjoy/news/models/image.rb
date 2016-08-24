module Enjoy::News
  module Models
    module Image
      extend ActiveSupport::Concern

      include Enjoy::News.orm_specific('Image')

      included do
      end

      def image_styles
        Enjoy::News.configuration.images_image_styles
      end
    end
  end
end
