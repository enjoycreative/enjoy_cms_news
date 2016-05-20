module Enjoy::News
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do
          field :name, type: String, localize: Enjoy::News.config.localize, default: ""

          field :time, type: Time
          index({enabled: 1, time: 1})

          enjoy_cms_html_field :excerpt, type: String, localize: Enjoy::News.configuration.localize, default: ""
          enjoy_cms_html_field :content, type: String, localize: Enjoy::News.configuration.localize, default: ""

          has_and_belongs_to_many :categories, class_name: "Enjoy::News::Category", inverse_of: nil

          scope :after_now, -> { where(:time.lt => Time.now) }
          scope :by_date, -> { desc(:time) }

          if Enjoy::News.config.gallery_support
            embeds_many :images, cascade_callbacks: true, class_name: "Enjoy::News::Image"
          end

        end

        def image_styles
          Enjoy::News.configuration.news_image_styles
        end

        def image_jcrop_options
          {}
        end
      end
    end
  end
end
