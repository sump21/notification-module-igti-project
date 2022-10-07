# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_924_191_912) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'applications', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'events_notifications', force: :cascade do |t|
    t.string 'event'
    t.string 'action'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'logs_notifications', force: :cascade do |t|
    t.bigint 'application_id', null: false
    t.bigint 'events_notification_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['application_id'], name: 'index_logs_notifications_on_application_id'
    t.index ['events_notification_id'], name: 'index_logs_notifications_on_events_notification_id'
  end

  add_foreign_key 'logs_notifications', 'applications'
  add_foreign_key 'logs_notifications', 'events_notifications'
end
