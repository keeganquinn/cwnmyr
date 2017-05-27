admin = CreateAdminService.new.call
puts 'ADMIN USER: ' << admin.email

user = CreateUserService.new.call
puts 'NORMAL USER: ' << user.email

group = Group.find_or_create_by(code: 'not', name: 'Network Operations Team')
puts 'GROUP: ' << group.code


hostType = HostType.find_or_create_by(code: 'test', name: 'Test Device')
puts 'HOST TYPE: ' << hostType.code

airrouter = HostType.find_or_create_by(code: 'airrouter', name: 'AirRouter')
puts 'HOST TYPE: ' << airrouter.code

apu = HostType.find_or_create_by(code: 'apu', name: 'APU')
puts 'HOST TYPE: ' << apu.code

alix = HostType.find_or_create_by(code: 'alix', name: 'ALIX')
puts 'HOST TYPE: ' << alix.code

bullet = HostType.find_or_create_by(code: 'bullet', name: 'BULLET')
puts 'HOST TYPE: ' << bullet.code

dir860l = HostType.find_or_create_by(code: 'dir860l', name: 'DIR860L')
puts 'HOST TYPE: ' << dir860l.code

mr24 = HostType.find_or_create_by(code: 'mr24', name: 'MR24')
puts 'HOST TYPE: ' << mr24.code

mr3201a = HostType.find_or_create_by(code: 'mr3201a', name: 'MR3201A')
puts 'HOST TYPE: ' << mr3201a.code

net4521 = HostType.find_or_create_by(code: 'net4521', name: 'NET4521')
puts 'HOST TYPE: ' << net4521.code

net4826 = HostType.find_or_create_by(code: 'net4826', name: 'NET4826')
puts 'HOST TYPE: ' << net4826.code

rb493g = HostType.find_or_create_by(code: 'rb493g', name: 'RB493G')
puts 'HOST TYPE: ' << rb493g.code

rocket = HostType.find_or_create_by(code: 'rocket', name: 'ROCKET')
puts 'HOST TYPE: ' << rocket.code

rsta = HostType.find_or_create_by(code: 'rsta', name: 'RSTA')
puts 'HOST TYPE: ' << rsta.code

soekris = HostType.find_or_create_by(code: 'soekris', name: 'Soekris')
puts 'HOST TYPE: ' << soekris.code

wgt634u = HostType.find_or_create_by(code: 'wgt634u', name: 'WGT634U')
puts 'HOST TYPE: ' << wgt634u.code

wdr3600 = HostType.find_or_create_by(code: 'wdr3600', name: 'WDR3600')
puts 'HOST TYPE: ' << wdr3600.code

wndr3800 = HostType.find_or_create_by(code: 'wndr3800', name: 'WNDR3800')
puts 'HOST TYPE: ' << wndr3800.code

wzr600dhp = HostType.find_or_create_by(code: 'wzr600dhp', name: 'WZR600DHP')
puts 'HOST TYPE: ' << wzr600dhp.code


interfaceType = InterfaceType.find_or_create_by(code: 'test', name: 'Test Interface')
puts 'INTERFACE TYPE: ' << interfaceType.code

pub = InterfaceType.find_or_create_by(code: 'pub', name: 'Public Network')
puts 'INTERFACE TYPE: ' << pub.code

priv = InterfaceType.find_or_create_by(code: 'priv', name: 'Private Network')
puts 'INTERFACE TYPE: ' << priv.code


statusActive = Status.find_or_create_by(code: 'active', name: 'Active', color: 'green')
puts 'STATUS: ' << statusActive.code

statusPending = Status.find_or_create_by(code: 'pending', name: 'Pending', color: 'yellow')
puts 'STATUS: ' << statusPending.code

statusInactive = Status.find_or_create_by(code: 'inactive', name: 'Inactive', color: 'red')
puts 'STATUS: ' << statusInactive.code

statusRetired = Status.find_or_create_by(code: 'retired', name: 'Retired', color: 'gray')
puts 'STATUS: ' << statusRetired.code

statusNotPtpManaged = Status.find_or_create_by(code: 'not_ptp_managed', name: 'Not PTP Managed', color: 'brown')
puts 'STATUS: ' << statusNotPtpManaged.code

statusTest = Status.find_or_create_by(code: 'test', name: 'Testing', color: 'orange')
puts 'STATUS: ' << statusTest.code


zone = Zone.find_or_create_by(code: 'pdx', name: 'P-Town')
puts 'ZONE: ' << zone.code
