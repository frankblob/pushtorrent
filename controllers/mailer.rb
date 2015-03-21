class MailSender < Que::Job

	require 'net/smtp'
	Que.mode = :async

	def mailit!(to, message)
		smtp = Net::SMTP.new('smtp.gmail.com', 587)
		smtp.enable_starttls
		smtp.start('gmail.com', ENV['mailfrom'], ENV['mailpass'], :plain) do |smtp|
			smtp.send_message(message, ENV['mailfrom'], to)
		end
	end
end

class SignupConfirmation < MailSender
	def run(to)
		from = ENV['mailfrom']
		subject = "Welcome to #{ENV['sitename']} - signup complete!"
		body = "Welcome to #{ENV['sitename']} - I'm glad to have you on board!\n\nYou have successfully signed up and everything is ready to go.\n\nAnd that's very cool.\n\nGo to #{ENV['siteurl']} and set up your first pushtorrent.\n\nSee you soon.\n\n\nRegards,\n\nFrank, the friendly mail robot at #{ENV['sitename']}\n\n**********************************\nThis email was automatically generated. Do not reply to this email adress. Instead, if you have questions, feedback or suggestions, please go to #{ENV['siteurl']}/contact\n**********************************"
		message = "From: #{ENV['sitename']} - NO REPLY/AUTO-EMAIL <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
		mailit!(to, message)
		DB.transaction do
			destroy
		end
	end
end

class NewTorrents < MailSender
	def run(to, torrents)
		from = ENV['mailfrom']
		subject = "Yay! New #{torrents.length < 2 ? 'torrent is' : 'torrents are'} released. Go download!"
		body = "New #{torrents.length < 2 ? 'torrent' : 'torrents'} released for:\n\n#{torrents.join("\n")}\n\nWe will push new torrent releases to you, if you leave everything as is. Easy-peasy.\n\nEnjoy downloading!\n\nFrank, the friendly mailer robot at #{ENV['sitename']}\n\n\n\n************************************\nTo cancel or adjust future torrent notifications, please go to #{ENV['siteurl']} and login.\n"
		message = "From: #{ENV['sitename']} <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
		mailit!(to, message)
	end
end

class UpdateAdmin < MailSender
	def run(body)
		to = ENV['adminmail']
		from = ENV['mailfrom']
		subject = "Daily tracker update statistics"
		body = "#{body.length} new torrent #{body.length == 1 ? 'release' : 'releases'} for #{body.length > 0 ? body.join(', ') : 'any trackers '} found during the last 24 hours."
		message = "From: #{ENV['sitename']} <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
		mailit!(to, message)
	end
end

class AdminUserUpdateStats < MailSender
		def run(subject, body)
		to = ENV['adminmail']
		from = ENV['mailfrom']
	#	subject = "User update emails sent successfully"
		message = "From: #{ENV['sitename']} <#{from}>\nTo: #{to}\nSubject: #{subject}\n\n#{body}"
		mailit!(to, message)
	end
end