namespace :gettext do
  desc "Update pot/po files for L10n" 
  task :po do
    require 'gettext/utils'
    require 'haml_parser'
    GetText.update_pofiles 'cwnmyr',
      Dir.glob("{app,lib}/**/*.{rb,rhtml,haml}"), 'cwnmyr 0.0.1'
  end

  desc "Create mo-files for L10n" 
  task :mo do
    require 'gettext/utils'
    GetText.create_mofiles true, "po", "locale"
  end
end
