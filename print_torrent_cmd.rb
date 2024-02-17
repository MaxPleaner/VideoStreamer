name, path, magnet = ARGV.first(3)

str = [
	%[screen -dmS #{name}],
	%[transmission-cli],
	%[-f ~/Desktop/VideoStreamer/kill_transmission],
	%[-w "/mnt/share/#{path}" "#{magnet}"],
].join(" ")


puts str
