class LogsNotification < ApplicationRecord
  belongs_to :application
  belongs_to :events_notification
end
