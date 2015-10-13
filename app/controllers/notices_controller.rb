class NoticesController < ApplicationController
  def index
    @notices = Notice.all.where(user_id: current_user.id)
  end
end
