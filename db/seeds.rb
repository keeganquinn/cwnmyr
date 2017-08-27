admin = CreateAdminService.new.call
puts 'ADMIN USER: ' << admin.email

user = CreateUserService.new.call
puts 'NORMAL USER: ' << user.email

records = PopulateOptionsService.new.call
puts 'OPTION RECORDS: ' << records.size.to_s

nodes = ImportLegacyDataService.new.call
nodes.each do |node|
  print 'IMPORTED NODE: ', node.code, ': ', node.name, ' @ ', node.id, "\n"
end
