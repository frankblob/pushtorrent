# Welcome to 'Torrent Watch' 
## AKA 'contribs/name suggestions are welcome'

Built with Ruby 2.2.0, [Sinatra](http://sinatrarb.com) 1.4.5 and [Nokogiri](http://www.nokogiri.org/) 1.6.5.

### Description of the web app's basic functionality
Torrent Watch lets users opt-in to receive email notifications when new torrents of choice are ready for download. No need to do daily manual searches for newly released torrents, e.g. 'ruby on rails', 'the stranger 720p HD', 'FLAC' or similar.   

Why not get an email when the torrents you seek are released?

## To-do list
### Current Torrent Watch development bugs, issues, features and goals

### UX to-dos
1.Illogical redirect (false return) on "empty string" user input on results "page" -> redirected to front page.
  * Goal: Should stay on results "page", perhaps with flash error message.
2. Illogical redirect (false return) when user attempts to add a duplicate tracker - > redirected to front page with flash message ("You already have this tracker...").
  * Goal: Should stay on results "page".

### Roadmap / future functionality and features
1. Size and seeder sorted torrent search results.
2. Dynamically generate static pages for DB stored trackers (keywords/search terms)
  * Auto-updated site map, with updated child nodes.
3. Redesign the layout - with clear CTA
4. Email [check](https://github.com/mailcheck/mailcheck) & routine
5. Develop function for daily querying of trackers
  * Search and update trackers; send email to relevant users
  * Dynamically generate emails when new releases are found (+'buffer' model for interval digests?)
  * Update timedate field for notification, to secure only new releases are searched
6. Email sending. [Pony](https://rubygems.org/gems/pony) gem, gmail smtp, [Sendy](http://sendy.co/), [sendgrid](https://sendgrid.com/) or [campayn](http://campayn.com/)?
7. Develop / install user forum
  * Reuse user DB from app, to avoid double sign up in forum
  * [Discourse](http://www.discourse.org/)?
8. Enable adding a single tracker for unregistered users by entering email only + design view.
9. Produce simple instructional video for home page
10. Generate email template and create example email for viewing
11. Tests.
12. Dynamically generated list of 10 latest, most popular and highest seeded notifications, etc. along with 10 most recent forum
  * Cron-job for 10 min interval update of the above, stored in file, to reduce DB querying?
13. Swap to PostgreSQL, add [numerical constraints](https://rubygems.org/gems/rein) and [foreign key constraints](https://rubygems.org/gems/foreigner) (for referential integrity) at the database level.
14. Deploy :)

### To-do improvements
1. Check to_time gem necessity and time normalization in app and DB
2. Test Nokogiri replacements [Ox](https://rubygems.org/gems/ox) and [Oga](https://rubygems.org/gems/oga)

### Done
1. ~~Timedate sorted torrent list~~
2. ~~Add bootstrap~~ 
3. ~~Add ORM for persistence layer ([ROM](http://rom-rb.org), [Sequel](http://sequel.jeremyevans.net/), [ActiveRecord](http://github.com/janko-m/sinatra-activerecord) or [Lotus::Model](http://lotusrb.org/)~~
  * ~~User registration/sign up (self-coded, [Warden](https://rubygems.org/gems/warden) or [Omniauth Identity](https://github.com/intridea/omniauth-identity), [CanCan](https://github.com/shf/sinatra-can), etc.~~ 
  * ~~Log in~~
  * ~~User management of trackers~~
4. ~~Implement fall-back RSS feed~~
5. ~~Time-sorted feed from URL = 'ht<span>tps://</span>torrentz.eu/feedA?f='~~
6. ~~[BUG] Torrent results listing of MB, seeders and date/time is error-prone and shows "XX Y"  (eg. "68 2") for some torrents with XX (68) seeders and Y (2) leechers.~~

##### About me
The project described above seems more complex than actually doable for someone with my current coding skill set. My personal goal is to hack away at this steep challenge and learn as much as possible.  

In short I'm nobody, newbie and non-programmer. Dabbling in my first attempts at Ruby, object-oriented programming and GitHub. Torrent Watch is my first web application attempt besides auto-deploying a [RailsBricks3](http://railsbricks.net) app, since I could not get anything self-coded to work on Heroku :)

##### Ruby questions I currently wonder about... 
1. When do instance variables 'die'? Trying to understand the memory usage of Ruby apps...
2. Is it worth it to manually set an instance variable = nil, when no longer in use? Or will Ruby GC do it for me?
3. Why is GC for symbols great? Should I use symbols more and thereby, as a consequence, optimize the memory usage of the app?
3. Will performance and memory utilization improve by replacing Nokogiri with Ox, Oga or even [Curb](https://rubygems.org/gems/curb), in terms of installed gems alone? Not focucing on the performance of the individual gems (Nokogori vs Ox parsing, for instance), but the number, dependencies and size of installed gems.
4. Is it necessary to implement something akin to [referential integrity](https://github.com/orcasnet/activerecord-referential_integrity) for foreign keys in Sequel? Have done check and delete on "zero associations" in Sequel for now.

## Join this project
All help is welcome. I'm glad to share this project with any interested contributors; newbie, experienced, young and old, english-speaking or english-trying. Contribute as you best can.

For newbies as myself, that would perhaps be [correcting typos or similar](http://www.codenewbie.org/podcast/24-pull-requests) and submitting a [pull request](http://readwrite.com/2014/07/02/github-pull-request-etiquette) as detailed on the friendly, but easily over-stimulating pull request [walk-through](https://help.github.com/articles/using-pull-requests/) on Github. 

Try it - and you have started collaborating! 

Okay, that's it, I guess. 

**Stay cheerful**