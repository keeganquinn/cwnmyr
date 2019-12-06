# frozen_string_literal: true

unless User.admin.count.positive?
  admin = CreateAdminService.new.call
  puts "ADMIN USER: #{admin.email}"
end

unless User.user.count.positive?
  user = CreateUserService.new.call
  puts "NORMAL USER: #{user.email}"
end

PopulateOptionsService.new.call

importer = ImportLegacyDataService.new
importer.call.each do |node|
  puts "IMPORTED NODE: #{node.code}: #{node.name} @ #{node.id}"
end

eventer = ImportLegacyEventsService.new
eventer.call.each do |event|
  puts "IMPORTED EVENT: #{event.name}"
end
