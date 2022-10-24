puts 'Executing Seeds'
def get_yaml(yaml)
  puts "Finding file #{yaml}.yaml"

  yaml_file = YAML.safe_load(
    File.read(
      File.join(
        Rails.root.join("db/data/seeds/#{yaml}.yaml")
      )
    )
  )
  yaml_file[yaml]
end

puts 'Generating Applications'
get_yaml('applications').each do |application|
  Application.create(
    name: application
  ) unless Application.where(name: application).exists?
  print '-'
end

puts 'Generating Events Notifications'
get_yaml('events_notifications').each do |event|
  EventsNotification.create(
    event: event['event'],
    action: event['action']
  ) unless EventsNotification.where(
    event: event['event'],
    action: event['action']
  ).exists?
  print '-'
end
