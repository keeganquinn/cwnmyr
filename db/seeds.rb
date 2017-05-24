admin = CreateAdminService.new.call
puts 'ADMIN USER: ' << admin.email

user = CreateUserService.new.call
puts 'NORMAL USER: ' << user.email

group = Group.find_or_create_by(code: 'not', name: 'Network Operations Team')
puts 'GROUP: ' << group.code

hostType = HostType.find_or_create_by(code: 'test', name: 'Test Unit')
puts 'HOST TYPE: ' << hostType.code

interfaceType = InterfaceType.find_or_create_by(code: 'test', name: 'Test Port')
puts 'INTERFACE TYPE: ' << interfaceType.code

statusOk = Status.find_or_create_by(code: 'ok', name: 'Operational', color: 'green')
puts 'STATUS: ' << statusOk.code

statusPlanned = Status.find_or_create_by(code: 'planned', name: 'Planned', color: 'yellow')
puts 'STATUS: ' << statusPlanned.code

statusRetired = Status.find_or_create_by(code: 'retired', name: 'Retired', color: 'gray')
puts 'STATUS: ' << statusRetired.code

zone = Zone.find_or_create_by(code: 'pdx', name: 'P-Town')
puts 'ZONE: ' << zone.code
