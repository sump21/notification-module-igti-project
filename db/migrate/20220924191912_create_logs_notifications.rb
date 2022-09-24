class CreateLogsNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :logs_notifications do |t|
      t.references :application, null: false, foreign_key: true
      t.references :events_notification, null: false, foreign_key: true

      t.timestamps
    end
  end
end
