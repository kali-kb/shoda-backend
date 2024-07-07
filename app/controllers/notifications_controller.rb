class NotificationsController < ApplicationController


	def index
		@notifications = Notification.where(merchant_id: params[:merchant_id])
		render json: @notifications, status: :ok
	end

	def update
		notifications_ids = params[:notification_ids]
		logger.info "notification ids: #{notifications_ids}"
		@notifications = Notification.where(notification_id: [notifications_ids])
		@notifications.update_all(read: true)
		head :no_content
	end


end
