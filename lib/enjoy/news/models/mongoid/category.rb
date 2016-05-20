module Enjoy::News
  module Models
    module Mongoid
      module Category
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do
          field :name, type: String, localize: Enjoy::News.configuration.localize, default: ""

          scope :sorted, -> { order_by([:lft, :asc]) }

          enjoy_cms_html_field :excerpt,   type: String, localize: Enjoy::News.configuration.localize, default: ""
          enjoy_cms_html_field :content,   type: String, localize: Enjoy::News.configuration.localize, default: ""
        end

        def news
          news_class.in(category_ids: self.id)
        end

        def all_news
          news_class.any_in(category_ids: self.self_and_descendants.map(&:id))
        end
      end
    end
  end
end
