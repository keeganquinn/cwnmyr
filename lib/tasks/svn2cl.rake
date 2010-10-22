namespace :doc do
  desc 'Generate a ChangeLog from Subversion'
  task :changelog do |t|
    sh 'doc/svn2cl/svn2cl.sh'
  end
end
