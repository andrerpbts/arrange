# encoding: utf-8
require 'fileutils'

# It will generate a folder in the up directory 
destination_dir = "../_musics"
Dir.mkdir(destination_dir) unless File.directory?(destination_dir)

exported = 0
skipped  = 0

errors = []

Dir['**/*.mp3'].each { |file|
	parts = file.split(/-/)

	begin
		# it is expecting your file in this format: '123 - artist name - music name.mp3'
		# when it's splitted, the we have parts object whith:
		# [0] = 123
		# [1] = artist name
		# [2] = music name.mp3 

		artist = "#{destination_dir}/#{parts[1].strip}"
		Dir.mkdir(artist) unless File.directory?(artist)

		music = "#{artist}/#{parts[1].strip} - #{parts[2].strip}"

		unless File.exists?(music)
			FileUtils.cp file, music 
			exported += 1 
			print "."
		else
			skipped += 1 
			print "S"			
		end
	rescue Exception => e
		print "E"
		errors << "Error on export the music: #{file}\n#{e}\n\n"
	end
}

puts "\n\n#{exported} exported musics, #{skipped} skipped musics, #{errors.size} not exported musics"
errors.each { |error|
	puts error
}