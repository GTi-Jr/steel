class PhotosController < ApplicationController
  def index
    @photos = current_user.projects.find(param[:id]).photos
  end
end
