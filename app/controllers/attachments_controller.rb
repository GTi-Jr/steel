class AttachmentsController < ApplicationController
  def index
    @attachments = current_user.projects.find(param[:id]).attachments
  end
end
