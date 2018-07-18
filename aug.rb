require "fileutils"

Dir["neso_photos/*"].each do |member|
	FileUtils.cp_r("aug.py", "#{member}/aug.py", remove_destination: true)
	puts member
	`cd #{member} && python aug.py && cp aug/*.* . && rm -r aug`
end
