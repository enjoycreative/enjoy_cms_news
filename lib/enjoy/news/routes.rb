module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_news_routes(config = {})
      routes_config = {
        use_news_path: true,
        use_categories_path: true,
        classes: {
          news: :news,
          categories: :categories
        },
        paths: {
          news: :news,
          categories: :news_categories
        }
      }
      routes_config.deep_merge!(config)

      generate_enjoy_news_user_routes(routes_config)
      generate_enjoy_news_cms_routes(routes_config)

    end

    private
    def generate_enjoy_news_user_routes(routes_config)
      if !routes_config[:use_news_path] and !routes_config[:classes][:news].nil?
        resources routes_config[:classes][:news].to_sym, only: [:show], path: routes_config[:paths][:news] do
          get '(/page/:page)', action: :index, on: :collection, as: ""
        end
      end
      if !routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
        resources routes_config[:classes][:categories].to_sym, only: [:show], path: routes_config[:paths][:categories] do
          get '(/page/:page)', action: :index, on: :collection, as: ""
        end
      end
    end

    def generate_enjoy_news_cms_routes(routes_config)
      scope module: 'enjoy' do
        scope module: 'news' do
          if routes_config[:use_news_path] and !routes_config[:classes][:news].nil?
            resources routes_config[:classes][:news].to_sym, only: [:show], path: routes_config[:paths][:news], as: :enjoy_news_news do
              get '(/page/:page)', action: :index, on: :collection, as: ""
            end
          end
          if routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
            resources routes_config[:classes][:categories].to_sym, only: [:show], path: routes_config[:paths][:categories], as: :enjoy_news_categories do
              get '(/page/:page)', action: :index, on: :collection, as: ""
            end
          end
        end
      end
    end

  end
end
