require 'net/smtp'

def signup_confirmation(to)
	subject = "Welcome to #{settings.sitename} - signup complete!"
	body = "Welcome to #{settings.sitename} - I'm glad to have you on board!\n\nYou have successfully signed up and everything is ready to go.\n\nAnd that's very cool.\n\nGo to #{settings.siteurl} and set up your first torrent trackers. See you soon.\n\n\nRegards,\n\nFrank, the friendly mail robot at #{settings.sitename}\n\n**********************************\nThis email was automatically generated. Do not reply to this email adress. Instead, if you have questions, feedback or suggestions, please go to #{settings.siteurl}/contact\n**********************************"
	message = mailcomposer(to, subject, body)
	mailit!(to, message)
end

def mailcomposer(to, subject, body)
	from = settings.mailfrom
	to = to
	message = "From: #{settings.sitename} - NO REPLY/AUTO-EMAIL <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
end

def mailit!(to, message)
	smtp = Net::SMTP.new('smtp.gmail.com', 587)
	smtp.enable_starttls
	smtp.start('gmail.com', settings.mailfrom, settings.mailpass, :plain) do |smtp|
		smtp.send_message(message, settings.mailfrom, to)
	end
end

def update_admin(body)
	from = settings.mailfrom
	to = settings.adminmail
	subject = "Daily tracker update statistics"
	body = "#{body.length} new torrent releases for #{body.join(', ')} were found during the last 24 hours."
	message = "From: #{settings.sitename} <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
	mailit!(to, message)
end

def update_admin_userupdates(subject, body)
	from = settings.mailfrom
	to = settings.adminmail
#	subject = "User update emails sent successfully"
	message = "From: #{settings.sitename} <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
	mailit!(to, message)
end

def new_torrents(to, torrents)
	from = settings.mailfrom
	subject = "Yay! New #{torrents.length < 2 ? 'torrent is' : 'torrents are'} released. Go download!"
	body = "New #{torrents.length < 2 ? 'torrent' : 'torrents'} released for:\n\n#{torrents.join("\n")}\n\nWe will push new torrent releases to you, if you leave everything as is. Easy-peasy.\n\nEnjoy downloading!\n\nFrank, the friendly mailer robot at #{settings.sitename}\n\n\n\n************************************\nTo cancel or adjust future torrent notifications, please go to #{settings.siteurl} and login.\n"
	message = "From: #{settings.sitename} <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
	mailit!(to, message)
end
