class HomeController < ApplicationController
  def index
    @pro_listings = Company.all
    @free_listings = Company.all
  end
end
