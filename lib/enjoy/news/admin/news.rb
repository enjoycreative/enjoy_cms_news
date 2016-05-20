module Enjoy::News
  module Admin
    module News
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t('enjoy.news')
          list do
            scopes [:by_date, :enabled, nil]
          end

          field :enabled, :toggle do
            searchable false
          end
          field :time do
            searchable false
            sort_reverse true
          end
          field :name do
            searchable true
          end
          if Enjoy::News.config.pages_support
            group :connected_pages do
              active false
              field :connected_pages, :enjoy_connectable
            end
          end

          if Enjoy::News.config.gallery_support
            group :image do
              active false
              field :image, :jcrop do
                jcrop_options :image_jcrop_options
              end
              field :images
            end
          end
          group :content do
            active false
            field :excerpt, :enjoy_html do
              searchable true
            end
            # field :excerpt_html, :ck_editor
            # field :excerpt_clear, :toggle
          end
          group :URL do
            active false
            field :slugs, :enum do
              searchable true
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
            field :text_slug do
              searchable true
            end
          end

          list do
            sort_by :time
          end

          edit do
            group :content do
              active false
              field :content, :enjoy_html
              # field :content_html, :ck_editor
              # field :content_clear, :toggle
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
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
