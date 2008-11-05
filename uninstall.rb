require 'fileutils'
require 'digest/sha1'
require 'pathname'

rails_root = Pathname.new(File.join(File.dirname(__FILE__), '..', '..', '..')).realpath
directories_to_remove = []

FileUtils.chdir(File.join(File.dirname(__FILE__), 'install')) do
  Dir['**/*'].each do |pathname|
    destination = File.join(rails_root, pathname)
    next unless File.exist?(destination)
    if File.directory?(pathname)
      directories_to_remove << pathname
    else
      if Digest::SHA1.hexdigest(IO.read(pathname)) == Digest::SHA1.hexdigest(IO.read(destination))
        puts "Uninstalling #{pathname}"
        FileUtils.rm_f(destination)
      else
        puts "Warning: File '#{pathname}' differs from original. Please remove manually."
      end
    end
  end
end

directories_to_remove.sort_by{|e| e.count('/')}.reverse.each do |pathname|
  begin
    destination = File.join(rails_root, pathname)
    FileUtils.rmdir(destination) 
    puts "Removing Directory #{pathname}"
  rescue Errno::ENOTEMPTY
  end
end

puts "Uninstall Complete!"
puts ""
puts "You'll need to drop the 'admin_users' table manually."
puts ""
