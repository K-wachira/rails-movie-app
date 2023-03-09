class MainsController < ApplicationController
  def index
    if params[:search]
      redirect_to url_for('controller': 'searchs', 'action': 'search', 'search': params[:search])
    end
  end
end
