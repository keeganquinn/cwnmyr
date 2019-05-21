# frozen_string_literal: true

admin = CreateAdminService.new.call
puts "ADMIN USER: #{admin.email}"

user = CreateUserService.new.call
puts "NORMAL USER: #{user.email}"

records = PopulateOptionsService.new.call
puts "OPTION RECORDS: #{records.size}"

importer = ImportLegacyDataService.new
importer.call.each do |node|
  puts "IMPORTED NODE: #{node.code}: #{node.name} @ #{node.id}"
end
