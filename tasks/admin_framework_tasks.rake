require 'fileutils'

namespace :admin_framework do
  
  desc "Update Javascript/CSS for admin_framework plugin."
  task :update do
    FileUtils.chdir(File.join(File.dirname(__FILE__), '..')) do
      Dir['public/**/*'].each do |pathname|
        if File.directory?(pathname)
          FileUtils.mkdir_p File.join(RAILS_ROOT, pathname)
        else
          destination = File.join(RAILS_ROOT, pathname)
          if File.exist?(destination)
            puts "Warning: File '#{pathname}' exists. Overwriting..."
          else
            puts "Installing #{pathname}"
          end
          FileUtils.cp pathname, destination
        end
      end
      puts "Update Complete!"
    end
  end

end


