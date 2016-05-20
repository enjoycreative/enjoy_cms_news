module Enjoy::News
  class NewsController < ApplicationController
    include Enjoy::News::Controllers::News

    include Enjoy::News::Decorators::NewsController
  end
end
