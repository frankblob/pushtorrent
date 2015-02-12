require 'net/smtp'

def signup_confirmation(to)
	subject = "Welcome to #{settings.sitename} - signup complete!"
	body = "Welcome to #{settings.sitename} - I'm glad to have you on board!\n\nYou have successfully signed up and eveything is ready to go.\n\nAnd that's very cool.\n\nGo to #{settings.siteurl} and set up your first torrent trackers. See you soon.\n\n\nRegards,\n\nFrank, the friendly mail robot\n#{settings.sitename}\n\n**********************************\nThis email was automatically generated. Do not reply to this email adress - it is unmonitored. Instead, for questions, feedback and suggestions, please go to #{settings.siteurl}/contact\n**********************************"
	message = mailcomposer(to, subject, body)
	mailit!(to, message)
end

def mailcomposer(to, subject, body)
	from = settings.mailfrom
	to = to
	message = "From: Torrent Watch - NO REPLY/AUTO-EMAIL <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
end

def mailit!(to, message)
	smtp = Net::SMTP.new('smtp.gmail.com', 587)
	smtp.enable_starttls
	smtp.start('gmail.com', settings.mailfrom, settings.mailpass, :plain) do |smtp|
		smtp.send_message(message, settings.mailfrom, to)
	end
end

=begin
def tracker_notification(to, torrents)
	subject = "Yay! New torrents available for download."
	body = "It is a pleasure to inform you that Welcome to #{settings.sitename} - I'm glad to have you on board!\n\nYou have successfully signed up and eveything is ready to go.\n\nAnd that's very cool.\n\nGo to #{settings.siteurl} and set up your first torrent trackers. See you soon.\n\n\nRegards,\n\nFrank, the friendly mail robot\n#{settings.sitename}\n\n**********************************\nDo not reply to this email adress. It is not monitored. This email was automatically generated. Instead, please go to #{settings.siteurl}/contact\n**********************************"
	message = mailcomposer(to, subject, body)
	# something
	#{"Tracker keywords" => {"title1": releasetime1, "title2": releasetime2}}
	torrent.each do |k, v|
		puts "New '" + k + "' torrents:"
		v.each {|k,v| puts k.to_s + " (released " + v.to_s + ")"}
		puts ""
	end
end
=end
