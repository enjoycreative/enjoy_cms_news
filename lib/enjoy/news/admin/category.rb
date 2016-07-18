module Enjoy::News
  module Admin
    module Category
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t('enjoy.news')

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle do
              searchable false
            end
            field :name do
              searchable true
            end
            if Enjoy::News.config.pages_support
              field :connected_pages, :enjoy_connectable
            end
          end

          edit do
            field :enabled, :toggle
            field :name
            if Enjoy::News.config.pages_support
              group :connected_pages do
                active false
                field :connected_pages, :enjoy_connectable
              end
            end
            group :URL do
              active false
              field :slugs, :enjoy_slugs
              field :text_slug
            end


            if Enjoy::News.config.gallery_support
              group :image do
                active false
                field :image, :enjoy_image
                # field :item_category_images
              end
            end

            group :content do
              active false
              field :excerpt, :enjoy_html
              field :content, :enjoy_html
            end

            Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

            if Enjoy::News.config.seo_support
              group :seo do
                active false
                field :seo do
                  active true
                end
              end
              group :sitemap_data do
                active false
                field :sitemap_data do
                  active true
                end
              end
            end

            group :news do
              active false
              field :news do
                read_only true
                help 'Список Новостей'

                pretty_value do
                  bindings[:object].news.to_a.map { |n|
                    route = (bindings[:view] || bindings[:controller])
                    model_name = n.rails_admin_model
                    route.link_to(n.name, route.rails_admin.show_path(model_name: model_name, id: n.id), title: n.name)
                  }.join("<br>").html_safe
                end
              end
            end
          end

          show do
            field :name
            field :slugs, :enum do
              enum_method do
                :slugs
              end
              visible do
                bindings[:view].current_user.admin?
              end
              multiple do
                true
              end
            end
            field :text_slug
            field :enabled
            field :image
            field :excerpt
            field :content

            Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

            field :news do
              read_only true

              pretty_value do
                bindings[:object].news.to_a.map { |n|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = n.rails_admin_model
                  route.link_to(n.name, route.rails_admin.show_path(model_name: model_name, id: n.id), title: n.name)
                }.join("<br>").html_safe
              end
            end
          end

          nested_set({max_depth: 2, scopes: []})

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
