class StaticController < ApplicationController

  def index
    render layout: false
  end
end
