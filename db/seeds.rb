users = [
  { first_name: 'John', last_name: 'Doe', email: 'jhon@example.com', password: 'foobar' },
  { first_name: 'Jane', last_name: 'Doe', email: 'jane@example.com', password: 'foobar' },
  { first_name: 'John', last_name: 'Smith', email: 'john.smith@example', password: 'foobar' },
]

services = [
  { name: 'Monitoring Service 1', description: 'Service 1 description' },
  { name: 'Monitoring Service 2', description: 'Service 2 description' },
  { name: 'Monitoring Service 3', description: 'Service 3 description' },
]

users.each do |user|
  User.create(user)
end

services.each do |service|
  created_service = Service.create(service)

  5.times do |i|
    start_hour = 8 + i % 10
    start_time = (Time.now + i.days).change(hour: start_hour, min: 0, sec: 0)
    end_time = start_time + 1.hour
    MonitoringRequest.create(service: created_service, start_time: start_time, end_time: end_time)
  end
end