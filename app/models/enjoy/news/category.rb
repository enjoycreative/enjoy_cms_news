module Enjoy::News
  class Category
    include Enjoy::News::Models::Category

    include Enjoy::News::Decorators::Category

    rails_admin(&Enjoy::News::Admin::Category.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
