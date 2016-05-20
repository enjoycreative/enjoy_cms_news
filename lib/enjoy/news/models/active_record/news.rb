module Enjoy::News
  module Models
    module ActiveRecord
      module News
        extend ActiveSupport::Concern
        included do
          if Enjoy::News.config.gallery_support
            has_many :images, as: :enjoy_gallery_imagable, class_name: 'Enjoy::News::Image'
          end

          has_paper_trail

          validates_lengths_from_database only: [:name, :content_html, :excerpt_html]

          scope :after_now, -> { where("time < ?", Time.now) }
          scope :by_date, -> { order(time: :desc) }

          if Enjoy::News.config.localize
            translates :name, :content_html, :excerpt_html
          end

          has_and_belongs_to_many :categories,
                                  class_name: "Enjoy::News::Category",
                                  join_table: :enjoy_news_news_categories
        end
      end
    end
  end
end
