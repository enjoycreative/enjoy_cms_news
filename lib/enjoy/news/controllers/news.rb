module Enjoy::News
  module Controllers
    module News
      extend ActiveSupport::Concern

      def index
        @news = news_class.enabled.after_now.by_date

        unless Enjoy::News.config.news_per_page.nil?
          @news = @news.page(params[:page]).per(Enjoy::News.config.news_per_page)
        end

        after_initialize
      end

      def show
        @news = news_class.after_now.find(params[:id])

        if @news and @news.text_slug != params[:id]
          redirect_to @news, status_code: 301
          return true
        end

        after_initialize
      end

      private
      def category_class
        Enjoy::News::Category
      end
      def news_class
        Enjoy::News::News
      end
      def page_title
        if @news.class == news_class
          @news.page_title
        else
          super
        end
      end

      def after_initialize
      end
    end
  end
end
