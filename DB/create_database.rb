puts 'Crendo base de datos ...'
file_path = File.join(File.dirname(__FILE__), 'mocknequi.sql').split(' ')
file_path_string = ''
file_path.each do |space|
  file_path_string += "#{space}\x5c "
end
file_path_string = file_path_string.chop.chop
system("#{ENV['mysql_executable']} -h #{ENV['host']} -u root #{ENV['db_name']} < #{file_path_string}")
