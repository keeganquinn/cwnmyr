# Copy the images (*.gif,*.png) into RAILS_ROOT/public/images/colorpicker
# Copy the javascript files (*.js) into RAILS_ROOT/public/javascripts
# Copy the css files (*.css) into RAILS_ROOT/public/stylesheets
unless defined?(RAILS_ROOT)
  RAILS_ROOT = File.join(File.dirname(__FILE__), '../../../')
end

unless FileTest.exist? File.join(RAILS_ROOT, 'public', 'images', 'colorpicker')
  FileUtils.mkdir( File.join(RAILS_ROOT, 'public', 'images', 'colorpicker') )
end

FileUtils.cp( 
  Dir[File.join(File.dirname(__FILE__), 'resources', 'public', 'images', 'colorpicker', '*.gif')], 
  File.join(RAILS_ROOT, 'public', 'images', 'colorpicker'),
  :verbose => true
)

FileUtils.cp( 
  Dir[File.join(File.dirname(__FILE__), 'resources', 'public', 'images', 'colorpicker', '*.png')], 
  File.join(RAILS_ROOT, 'public', 'images', 'colorpicker'),
  :verbose => true
)

FileUtils.cp( 
  Dir[File.join(File.dirname(__FILE__), 'resources', 'public', 'javascripts', '*.js')], 
  File.join(RAILS_ROOT, 'public', 'javascripts'),
  :verbose => true
)

FileUtils.cp( 
  Dir[File.join(File.dirname(__FILE__), 'resources', 'public', 'stylesheets', '*.css')], 
  File.join(RAILS_ROOT, 'public', 'stylesheets'),
  :verbose => true
)

# Show the INSTALL text file
#puts IO.read(File.join(File.dirname(__FILE__), 'INSTALL'))
