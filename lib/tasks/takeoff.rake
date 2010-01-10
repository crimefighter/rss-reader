namespace :sass do
  #TODO this doesn't work with multiple template directories.
  task :clear => :environment do
    Dir.glob("#{Sass::Plugin.options[:template_location]}/*.sass").each do |path|
      filename = File.basename path, '.sass'
      unless filename[0,1] == '_'
        File.delete "#{Sass::Plugin.options[:css_location]}/#{filename}.css" rescue nil
      end
    end
  end
end

namespace :maint do
  require 'fileutils'

  task :begin do
    FileUtils.touch RAILS_ROOT + '/tmp/maintenance.txt'
  end
  
  task :end do
    File.unlink RAILS_ROOT + '/tmp/maintenance.txt'
  end

end

task :restart do
  require 'fileutils'

  FileUtils.touch RAILS_ROOT + '/tmp/restart.txt'
end
