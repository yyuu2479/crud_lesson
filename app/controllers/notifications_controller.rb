class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).page(params[:page]).per(20)
    
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end

  end
end
