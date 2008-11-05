require 'fileutils'
require 'pathname'

rails_root = Pathname.new(File.join(File.dirname(__FILE__), '..', '..', '..')).realpath

FileUtils.chdir(File.join(File.dirname(__FILE__), 'install')) do
  Dir['**/*'].each do |pathname|
    if File.directory?(pathname)
      puts "Making Directory #{pathname}"
      FileUtils.mkdir_p File.join(rails_root, pathname)
    else
      destination = File.join(rails_root, pathname)
      if File.exist?(destination)
        puts "Warning: File '#{pathname}' exists. Might want to check that out."
      else
        puts "Installing #{pathname}"
        FileUtils.cp pathname, destination
      end
    end
  end
end

puts "Install Complete!"
puts ""
puts IO.read(File.join(File.dirname(__FILE__), 'README'))
