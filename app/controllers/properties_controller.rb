class PropertiesController < ApplicationController
  def index
    properties = Property.all.order(date_on_deed: :desc)
    render json: properties
  end

  def refresh
    Property.refresh_properties
    properties = Property.all.order(date_on_deed: :desc)
    render json: properties
  end
end
