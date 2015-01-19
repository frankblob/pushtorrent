require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/string/conversions'
#Gems and config for Sequel ORM data persistence 
#require 'sequel'
#require 'sqlite3'
#DB = Sequel.sqlite('app.db')

get '/' do
	erb :search
end

post '/' do
	redirect back if params[:keywords].empty?
	keywords = params[:keywords].tr('^-a-zA-z0-9_.', ' ').split(' ').join('+')
	url = 'https://torrentz.eu/feed?q=' + keywords
	@keywords = keywords.split('+').join(' ')
	data = Nokogiri::XML(open(url))
	@items = data.xpath('//channel/item').sort_by{|x| x.at_css('pubDate').text.to_time}.reverse
	@items.empty? ? (erb :zerohits) : (erb :results)
end

get '/user' do
	erb :login
end

post '/user' do
	erb :userpage
end

get '/about' do
	erb :about
end

get '/contact' do
	erb :contact
end

get '/signup' do
	erb :signup
end

get '/forum' do
	erb :forum
end

not_found do
	status 404
	erb :four04, layout: false
end

__END__
@@layout
<!DOCTYPE HTML>
<html lang='en'>
	<head>
		<meta charset="utf8">
		<title>Torrent Watch</title>
		<link href="/style.css" rel="stylesheet" media="screen, projection">
		<!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
	</head>
	<body>
	<header>
		<hgroup>
			<div><h1><a href="/">Torrent Watch</a></h1>
      <h3>Get torrent notifications in your inbox</h3>
      </div>
			<div><a href="/signup">Sign up</a> | <a href="/user">Log in</a> | <a href="/forum">Forum</a>
			</div>
    </hgroup>
  </header>

  <div id="main">
	<%= yield %>
	</div>

	<footer>
    <p><small>Actionable intel on the torrents you need.<br/>
    SSL: <a href="/">Torrent watch</a> | <a href="/about">About</a> | <a href="/contact">Contact</a><br/>
    Disclaimer: Torrent Watch does neither support nor condone using torrents for illegal purposes or downloading copyrighted material. Think!</small></p>
  </footer>

@@search
<h2>Find your torrent</h2>
<div>
<form action='/' method='POST'>
	<input type='text' placeholder='The Stranger HD 720p' name='keywords'><input type='submit' value='Search'>
</form>
<p>Get notified when torrents you want are available for download.</p>
</div>
<div>
	<h3>Try the 11-second tutorial. Easy-peasy.</h3>
<iframe width="350" height="197" src="//www.youtube.com/embed/ScMzIvxBSi4?rel=0&showinfo=0&modestbranding=1&theme=light&controls=0&color=white" frameborder="0" allowfullscreen></iframe>
</div>

@@results
<h2>Get notified about new '<%= @keywords %>' torrents</h2>
<p>We will notify you when new <strong>'<%= @keywords %>'</strong> torrents are ready for you to download.<br/></p>
<table><tr>
<td>
Get notified of new <strong>'<%= @keywords %>'</strong> torrents<br/>
<small>Since you already know about the torrents below,<br/>you will only be notified about new releases. Nifty!<br/><a href="#">View example</a></small> 
</td>
<td>
<div>
<form action='/notification' method='POST'>
	<input type='text' placeholder='email@example.com' name='email'><input type='submit' value='Get notified'>
</form>
<small>No monkey business. Promise.</small>
</td>
</tr>
</table>
<h3>Search results for '<%= @keywords %>': #file_size | #seeders | #date_uploaded </h3>
<ul><% @items.each do |li| %>
<li><a href="<%= li.at_css('link').text %>"><%= li.at_css('title').text %></a><br />Size: <%= li.at_css('description').text[0,11].tr("^0-9,.", ' ').strip %> MB | Seeders: <%= li.at_css('description').text[16,14].tr("^0-9,.", ' ').strip %> | Released: <%= li.at_css('pubDate').text[5,11] %><br/>
<br/>
<% end %>
</ul>

@@zerohits
<h2>Get notified!</h2>
<p>We will continuously monitor the torrent indexes for <strong>'<%= @keywords %>'</strong> for you.</p>
<p>Immediately your wanted torrent comes online we will send you a notification. Kick back, relax and enjoy. The good news is soon to come...</p>
<p>Way better this way...</p>

@@userpage
<strong>Change menu to "Log out"...</strong>
<h2>You are now logged in to Torrent Watch.</h2>
<div>
<p>
Your notifications: sort by name | sort by created_date <br/>
<ul>
<li>
"Fictional user FLAC 01" - <a href="#">Edit</a> | <a href="#">Pause</a> | <a href="#">Remove</a>]<br />
Notification: immediately, daily, weekly [x], monthly.
</li>
<li>
"Fictional user movie 01" - <a href="#">Edit</a> | <a href="#">Pause</a> | <a href="#">Remove</a>]<br />
Notification: immediately, daily, weekly, monthly [x].
</li>
<li>
"Fictional user epub 01" - <a href="#">Edit</a> | <a href="#">Pause</a> | <a href="#">Remove</a>]<br />
Notification: immediately, daily, weekly [x], monthly.
</li>
<li>
"Fictional user mp3 album 01" - <a href="#">Edit</a> | <a href="#">Pause</a> | <a href="#">Remove</a>]<br />
Notification: immediately [x], daily, weekly, monthly.
</li>
<li>
"Fictional user mp3 album 02" - <a href="#">Edit</a> | <a href="#">Pause</a> | <a href="#">Remove</a>]<br />
Notification: immediately [x], daily, weekly, monthly.
</li>
<p>
Active notification trackers: 5</p>
<p><a href="#">Notification archive</a> (22 listings)
</p>

<h2>Profile info</h2>
Name: Firstname Lastname [<a href="#">edit</a>]<br/>
Member since: datetime<br/>
Email: your@example.com [<a href="#">change</a>]<br/>
Password: [<a href="#">change</a>]<br/>
Number of <a href="#">forum</a> posts: 1<br/>
Last forum post: <a href="#">*NOOB* Why is there no category selection possible?</a><br/>
<a href="#">Delete account</a> (confirmation required)<br/>
</p>
</div>

@@login
<h2>Log in to Torrent Watch</h2>
<div>
<form action='/user' method='POST'>
	<input type='text' placeholder='Email address' name='username'>
	<input type='text' placeholder='Password' name='password'>
	<input type='submit' value='Log in'>
</form>
<p>Enter your email address and password if you are an existing user.</p>
<p>If you want to create an account, then <a href="#">sign up</a> immediately!
</div>

@@about
<h2>About Torrent Watch</h2>
<div>
<p>Details, feature roadmap, history, team, etc.</p>
</div>

@@contact
<h2>Contact</h2>
<div>
<p>FAQ and Contact form</p>
</div>

@@forum
<h2>Forum</h2>
<div>
<p>Integrated forum or redirect to stand-alone forum.</p>
</div>

@@signup
<h2>Sign up - join!</h2>
<div>
<p>Sign up form with simple email and password validation.</p>
</div>

@@four04
<h1>Can we help you in another way, perhaps?</h1>
<p>We really wanted to do that for you. But just can't.</p>
<p>How about we serve you the <a href="/">Torrent Watch homepage</a> instead?</p> 
<p>We could also offer to search for a torrent for you?<br/>We'll do it really quick, too!</p>
<div>
	<form action='/' method='POST'>
	<input type='text' placeholder='The Stranger HD 720p' name='keywords'><input type='submit' value='Search'>
	</form>
</div>