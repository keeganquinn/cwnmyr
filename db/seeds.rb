admin = CreateAdminService.new.call
puts 'ADMIN USER: ' << admin.email

user = CreateUserService.new.call
puts 'NORMAL USER: ' << user.email

records = PopulateOptionsService.new.call
puts 'OPTION RECORDS: ' << records.size.to_s
