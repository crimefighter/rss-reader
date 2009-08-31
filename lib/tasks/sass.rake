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
