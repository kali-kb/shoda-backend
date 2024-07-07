class RemoveIdToNotificationIdInNotifications < ActiveRecord::Migration[7.1]
  def change
    rename_column :notifications, :id, :notification_id
  end
end
