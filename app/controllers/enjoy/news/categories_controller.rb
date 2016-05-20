module Enjoy::News
  class CategoriesController < ApplicationController
    include Enjoy::News::Controllers::Categories

    include Enjoy::News::Decorators::Categories
  end
end
