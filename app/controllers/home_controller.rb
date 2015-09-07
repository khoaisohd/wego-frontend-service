class HomeController < ApplicationController
  def index
    render HomeHelper.index_view_template
  end
end