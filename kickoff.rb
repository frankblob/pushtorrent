require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do
	erb :search
end

post '/' do
	keywords = params[:keywords].tr('^-a-zA-z0-9_.', ' ').split(' ').join('+')
	url = 'https://torrentz.eu/feed?q=' + keywords
	data = Nokogiri::XML(open(url))
	@items = data.xpath('//channel/item')
	erb :results
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
			<div>Sign up | Log in | Forum
			</div>
    </hgroup>
  </header>

  <div id="main">
	<%= yield %>
	</div>

	<footer>
    <p><small>Actionable intel on the torrents you need.<br/>
    SSL: <a href="/">Torrent watch</a> | <a href="/about">About</a> | <a href="/contact">Contact</a></small></p>
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
<h2>Torrent hits:</h2>
<p>Search results: | #seeders | #date_uploaded | #file_size</p>
<p><a href="#">Result 001</a> | seeders | uploaded_date | size<br/>
text snippet | photo (hover)<br/>
<a href="#">wikipedia</a> | <a href="#">imdb</a></p>
<ul><% @items.each do |li| %>
	<li><%= li.at_css('title').text %></li>
	<li><%= li.at_css('link').text %></li>
	<li><%= li.at_css('description').text %></li>
	<br/>
<% end %>
</ul>

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