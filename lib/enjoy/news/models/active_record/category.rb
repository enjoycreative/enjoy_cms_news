module Enjoy::News
  module Models
    module Mongoid
      module Category
        extend ActiveSupport::Concern

        included do
          has_paper_trail

          validates_lengths_from_database only: [:name, :content_html, :excerpt_html]

          scope :sorted, -> { order(lft: :asc) }

          if Enjoy::News.config.localize
            translates :name, :content_html, :excerpt_html
          end

          has_and_belongs_to_many :news,
                                  class_name: "Enjoy::News::News",
                                  join_table: :enjoy_news_news_categories
        end
      end
    end
  end
end
