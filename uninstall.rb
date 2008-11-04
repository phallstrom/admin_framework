require 'fileutils'
require 'digest/sha1'

rails_root = File.join(File.dirname(__FILE__), '..', '..', '..')
directories_to_remove = []

Dir['public/**/*'].each do |pathname|
  destination = File.join(rails_root, pathname)
  next unless File.exist?(destination)
  if File.directory?(pathname)
    directories_to_remove << pathname
  else
    if Digest::SHA1.hexdigest(IO.read(pathname)) == Digest::SHA1.hexdigest(IO.read(destination))
      puts "Removing #{pathname}"
      FileUtils.rm_f(destination)
    else
      puts "Warning: File '#{pathname}' differs from original. Please remove manually."
    end
  end
end

directories_to_remove.each do |pathname|
  begin
    destination = File.join(rails_root, pathname)
    FileUtils.rmdir(destination) 
    puts "Removing #{pathname}"
  rescue Errno::ENOTEMPTY
  end
end

puts "Uninstall Complete!"
puts ""
