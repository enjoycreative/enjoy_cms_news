module Enjoy::News
  if Enjoy::News.active_record?
    class News < ActiveRecord::Base
    end
  end

  class News
    include Enjoy::News::Models::News

    include Enjoy::News::Decorators::News

    rails_admin(&Enjoy::News::Admin::News.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
