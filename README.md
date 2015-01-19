# Welcome to 'Torrent Watch' 
## AKA 'contribs/name suggestions are welcome'

Built with Ruby 2.2.0, [Sinatra](http://sinatrarb.com) 1.4.5 and [Nokogiri](http://www.nokogiri.org/) 1.6.5.

### Description of the web app's basic functionality
No need for users to manually do daily torrent searches for new 'ruby on rails', 'the stranger 720p HD', 'FLAC' or similar. Torrent Watch lets users search and opt-in to receive email notifications when new torrents are ready for download.  

Why not get an email when the torrents you seek are released?

##### Roadmap / to-do list for future functionality and features

1. ~~Timedate sorted torrent list~~, allowing users to sort on size and seeders.
2. Dynamically generate static pages for notification search terms
  * Include site map, with updated child nodes.
3. Add bootstrap and design the layout with clear CTA
4. Add ORM for persistence layer (~~[ROM](http://rom-rb.org)~~, [Sequel](http://sequel.jeremyevans.net/) or ~~[Lotus::Model](http://lotusrb.org/)~~ for user registration and user management of notifications
  * Sign up (self-coded, [Warden](https://rubygems.org/gems/warden) or [Omniauth Identity](https://github.com/intridea/omniauth-identity), [CanCan](https://github.com/shf/sinatra-can), etc. + email routine
  * Log in
  * Manage notifications
5. Develop function for daily querying of notification search terms
  * Dynamically generate emails when new releases are found
  * Update timedate field for notification, to secure only new releases are searched
6. Develop / install user forum
  * Reuse user DB from app, to avoid double sign up in forum
7. Produce simple instructional video for home page
8. Generate email template and create example email for viewing
9. Tests.
10. Dynamically generated list of 10 latest, most popular and highest seeded notifications, etc. along with 10 most recent forum
11. Swap to PostgreSQL and deploy :)

##### About me
The project described above seems more complex than actually doable for someone with my current coding skill set. My personal goal is to hack away at this steep challenge and learn as much as possible.  

In short I'm nobody, newbie and non-programmer. Dabbling in my first attempts at Ruby, object-oriented programming and GitHub. Torrent Watch is my first web application attempt besides auto-deploying a [RailsBricks3](http://railsbricks.net) app, since I could not get anything self-coded to work on Heroku :)

##### Ruby questions I currently wonder about... 
1. Does instance variables use more memory than regular variables?
2. Is it worth it to manually set @variable = nil, when no longer in use - or will Ruby GC do it for me?
3. Will performance and memory utilization improve by replacing Nokogiri with [Curb](https://rubygems.org/gems/curb)?

## Join this project
All help is welcome. I'm glad to share this project with any interested contributors; newbie, experienced, young and old, english-speaking or english-trying. Contribute as you best can.

Okay, that's it, I guess. 

**Stay cheerful**