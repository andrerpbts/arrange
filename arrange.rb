# encoding: utf-8
require 'fileutils'

destination_dir = "../_musics"
Dir.mkdir(destination_dir) unless File.directory?(destination_dir)
exported = 0
skipped = 0
errors ||= []
Dir['**/*.mp3'].each { |file|
	parts = file.split(/-/)

	begin
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