if Enjoy::News.config.gallery_support
  module Enjoy::News
    _parent_class = Enjoy::Gallery::Image if Enjoy::News.active_record?
    _parent_class = Enjoy::Gallery::EmbeddedImage if Enjoy::News.mongoid?

    class Image < _parent_class
      include Enjoy::News::Models::Image

      include Enjoy::News::Decorators::Image

      rails_admin(&Enjoy::News::Admin::Image.config(nil, rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
