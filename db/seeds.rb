# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

period_ranges = [
  ['08:00', '08:50'],
  ['09:00', '09:50'],
  ['10:00', '10:50'],
  ['11:00', '11:50'],
  ['12:00', '12:50'],
  ['13:00', '13:50']
]

period_ranges.each do |(s, e)|
  Period.find_or_create_by!(start_time: s, end_time: e) do |p|
    p.label = "#{Time.zone.parse(s).strftime('%H:%M')}–#{Time.zone.parse(e).strftime('%H:%M')}"
  end
end
