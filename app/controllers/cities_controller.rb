class CitiesController < ApplicationController
  def index
    @popular_cities = StateCity.popular_cities
    @states = StateCity.states
  end
end
