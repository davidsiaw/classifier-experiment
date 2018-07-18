require "fileutils"
require 'digest/sha1'

terms = {
	honoka: ["honoka nesoberi", "寝そべり ほのか"],
	umi: ["umi nesoberi", "寝そべり 海未"],
	kotori: ["kotori nesoberi", "寝そべり ことり"],
	maki: ["maki nesoberi", "寝そべり 真姫"],
	rin: ["rin nesoberi", "寝そべり 凛"],
	hanayo: ["hanayo nesoberi", "寝そべり 花陽", "寝そべり かよちん"],
	eli: ["eli nesoberi", "寝そべり 絵里"],
	nozomi: ["nozomi nesoberi", "寝そべり 希"],
	nico: ["nico nesoberi", "寝そべり にこ"],
	yohane: ["yohane nesoberi", "寝そべり よはね", "yoshiko nesoberi", "寝そべり よしこ", "寝そべり 善子"],
	ruby: ["ruby nesoberi", "寝そべり ルビィ"],
	hanamaru: ["hanamaru nesoberi", "寝そべり 花丸"],
	dia: ["dia nesoberi", "寝そべり ダイヤ"],
	kanan: ["kanan nesoberi", "寝そべり 果南"],
	mari: ["mari nesoberi", "寝そべり マリ"],
	chika: ["chika nesoberi", "寝そべり 千歌"],
	you: ["you nesoberi", "寝そべり 曜"],
	riko: ["riko nesoberi", "寝そべり 梨子"],
	leah: ["leah nesoberi", "寝そべり 理亜"],
	sarah: ["sarah nesoberi", "聖良 寝そべり"],
}

filetypes = ["png","jpg","PNG","JPG"]

hs = {}
fs = {}

subject = ARGV[0]

if subject == "fixup"
	terms.each do |subject,v|
		filetypes.each do |typ|
			Dir["neso_photos/#{subject}/*.#{typ}"].each do |x|
				h = Digest::SHA1.hexdigest(File.read(x))
				hs[h] = true
				fs[x] = true
				dest = "neso_photos/#{subject}/#{h}.#{typ}"
				if x != dest
					FileUtils.mv(x, dest)		
				end
			end
		end
	end
	exit(0)
end

if !subject || !terms[subject.to_sym]
	puts "Enter valid term"
	terms.each {|k,v| puts "ruby dler.rb #{k}"}
	exit(1)
end


FileUtils.mkdir_p("neso_photos/#{subject}")

terms[subject.to_sym].each do |term|
	`python google-images-download.py -k "#{term}" -l 200 -o neso_photos`
	filetypes.each {|typ| `cp -f "neso_photos/#{term}/"*.#{typ} "neso_photos/#{subject}"` }
	FileUtils.rm_r("neso_photos/#{term}", force: true)
end

filetypes.each do |typ|
	Dir["neso_photos/#{subject}/*.#{typ}"].each do |x|
		h = Digest::SHA1.hexdigest(File.read(x))
		hs[h] = true
		fs[x] = true
		FileUtils.mv(x, "neso_photos/#{subject}/#{h}.#{typ}")
	end
end



# (Dir["*.png"] + Dir["*.jpg"] + Dir["*.PNG"] + Dir["*.JPG"]).each do |x|
# 	h = Digest::SHA1.hexdigest(File.read(x))
# 	hs[h] = true
# 	fs[x] = true
# 	#p "#{h} -> #{x}"
# 	FileUtils.mv(x, "#{h}.png")
# end
# p hs.count
# p fs.count