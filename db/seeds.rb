# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


AdminUser.create(email: 'admin@beerdispensers.com', password: 'Pass!@34')

d = Dispenser.create(flow_volume: 0.2, duration: 20, amount: 10)
d.dispense_events.create(start_time: 50.minutes.ago, end_time: 40.minutes.ago)
d.dispense_events.create(start_time: 1.minutes.ago, end_time: Time.now)
d.dispense_events.create(start_time: 5.minutes.ago, end_time: 1.minutes.ago)
d = Dispenser.create(flow_volume: 0.3, duration: 20, amount: 15)
d.dispense_events.create(start_time: 55.minutes.ago, end_time: 40.minutes.ago)
d.dispense_events.create(start_time: 1.minutes.ago, end_time: Time.now)
d.dispense_events.create(start_time: 5.minutes.ago, end_time: 1.minutes.ago)
d = Dispenser.create(flow_volume: 0.3, duration: 20, amount: 12)
d.dispense_events.create(start_time: 50.minutes.ago, end_time: 35.minutes.ago)
d.dispense_events.create(start_time: 10.minutes.ago, end_time: Time.now)
d.dispense_events.create(start_time: 6.minutes.ago, end_time: 3.minutes.ago)
d.dispense_events.create(start_time: 6.minutes.ago, end_time: 3.minutes.ago)
d.dispense_events.create(start_time: 30.minutes.ago, end_time: 10.minutes.ago)
d.dispense_events.create(start_time: 20.minutes.ago, end_time: 15.minutes.ago)
d.dispense_events.create(start_time: 25.minutes.ago, end_time: 20.minutes.ago)
d.dispense_events.create(start_time: 30.minutes.ago, end_time: 20.minutes.ago)
d.dispense_events.create(start_time: 35.minutes.ago, end_time: 20.minutes.ago)
d.dispense_events.create(start_time: 36.minutes.ago, end_time: 20.minutes.ago)