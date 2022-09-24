class CreateEventsNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :events_notifications do |t|
      t.string :event
      t.string :action

      t.timestamps
    end
  end
end

# create table applications(
#   id SERIAL NOT NULL,
#   event VARCHAR NOT NULL
#   action VARCHAR NOT NULL
# );
