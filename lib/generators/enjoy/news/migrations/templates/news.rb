class EnjoyNewsCreateNews < ActiveRecord::Migration
  def change
    ########### news #################
    create_table :enjoy_news_news do |t|
      t.boolean :enabled, default: true, null: false
      t.timestamp :time, null: false

      if Enjoy::News.config.localize
        t.column :name_translations, 'hstore', default: {}
        t.column :excerpt_html_translations, 'hstore', default: {}
        t.column :excerpt_clear_translations, 'hstore', default: {}
        t.column :content_html_translations, 'hstore', default: {}
        t.column :content_clear_translations, 'hstore', default: {}
      else
        t.string :name, null: false
        t.text :excerpt_html
        t.boolean :excerpt_clear, default: true, null: false
        t.text :content_html
        t.boolean :content_clear, default: true, null: false
      end

      t.string :slug, null: false
      t.attachment :image
      t.timestamps
    end

    add_index :enjoy_news_news, :slug, unique: true
    add_index :enjoy_news_news, [:enabled, :time]



    ######### news images ################
    # create_table :enjoy_news_news_images do |t|
    #   t.boolean :enabled, default: true, null: false
    #   t.integer :enjoy_news_news_id
    #
    #   if Enjoy::News.config.localize
    #     t.column :name_translations, 'hstore', default: {}
    #   else
    #     t.string :name, null: false
    #   end
    #
    #   t.attachment :image
    #   t.timestamps
    # end
    #
    # add_index :enjoy_news_news_images, [:enabled, :enjoy_news_news_id]




    ########### news_categories #################
    create_table :enjoy_news_categories do |t|
      t.boolean :enabled, default: true, null: false

      if Enjoy::News.config.localize
        t.column :name_translations, 'hstore', default: {}
        t.column :excerpt_html_translations, 'hstore', default: {}
        t.column :excerpt_clear_translations, 'hstore', default: {}
        t.column :content_html_translations, 'hstore', default: {}
        t.column :content_clear_translations, 'hstore', default: {}
      else
        t.string :name, null: false
        t.text :excerpt_html
        t.boolean :excerpt_clear, default: true, null: false
        t.text :content_html
        t.boolean :content_clear, default: true, null: false
      end

      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.string :slug, null: false
      t.attachment :image
      t.timestamps
    end

    add_index :enjoy_news_categories, :slug, unique: true
    add_index :enjoy_news_categories, [:enabled, :lft]



    ######### news <-> news_category join table #############

    create_join_table :enjoy_news_news, :enjoy_news_categories, table_name: :enjoy_news_news_categories

    add_foreign_key(:enjoy_news_news_categories, :enjoy_news_news, dependent: :delete)
    add_foreign_key(:enjoy_news_news_categories, :enjoy_news_categories, dependent: :delete)
  end
end
