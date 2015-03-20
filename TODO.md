## To-do list for MVP -> Beta -> RC -> 1.0 
### Current PushTorrent development bugs, issues, features and goals

### UX to-dos
1. Illogical redirect (false return) on "empty string" user input on results view -> redirected to front page.
  * Goal: Should stay on results "page", perhaps with flash error message (Ajax?)
2. Illogical redirect (false return) when user attempts to add a duplicate tracker - > redirected to front page with flash message ("You already have this tracker...").
  * Goal: Should stay on results "page" (Ajax?)

### Roadmap for core functionality / future features
1. Develop static site module for SEO-enhancement generated from DB stored trackers (keywords).
  * Auto-updated site map, with updated child nodes.
2. Develop forum
  * Reuse user DB from app, to avoid double sign up in forum
  * [Discourse](http://www.discourse.org/)?
3. Add [Que](https://github.com/chanks/que) to utilize modular architecture for UX speed enhancement.


### To-do improvements
1. Finalize remove account functionality via email confirmation [Nobi](https://github.com/cyx/nobi).
2. Implement single tracker cration for unregistered users by entering email only + design view/form.
3. Redesign the layout - with clear CTA
4. Size and seeder sorted torrent search results.
5. Produce simple instructional video for home page
6. Email [check](https://github.com/mailcheck/mailcheck)
7. Ajax UX improvements
8. Auto-reset of password via perishable token
9. Remember me-functionality
10. Merge/integrate app with separately developed updater, mailer and static page generation modules
  * Integrate as modular Sinatra app?
11. Learn and do testing
12. Dynamically generate list of 10 latest, most popular and highest seeded notifications, etc. along with 10 latest forum posts
  * Cron-job for 10 min interval update of the above, stored in file, to reduce DB querying?
13. Evaluate need for [numerical constraints](https://rubygems.org/gems/rein) and [foreign key constraints](https://rubygems.org/gems/foreigner) (for referential integrity) at the database level
14. Add option to change user password
15. Add user's forum activity to profile page; number of posts and latest post.
16. Develop option for setting update interval for trackers; immediately/hourly, daily, weekly or monthly, along with buffer storing updates until released frequency is reached.
17. Add 'pause' option for individual trackers
18. Integrate results from several different sources (will cause delay in display - or update dynamically? Wrid/glitchy UX?), checking for duplicates and sorting on release time.


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
7. ~~[BUG] NoMethodError on 'exists?' for nil:NilClass during signup.~~
8. ~~Develop user deletion procedure, including associations handling.~~
9. ~~Replaced Rails to_time gem to regular time gem.~~
10. ~~Module for daily querying of trackers~~
  * ~~Search and update trackers; send email to relevant users~~
  * ~~Dynamically generate emails when new releases are found~~
  * ~~Update timedate field for notification, to secure only new releases are searched~~
11. ~~Develop module for email sending. [Pony](https://rubygems.org/gems/pony) gem, gmail smtp, [Sendy](http://sendy.co/), [sendgrid](https://sendgrid.com/) or [campayn](http://campayn.com/)?~~
  * ~~Generate email template~~
12. ~~Switch to PostgreSQL~~
13. ~~Analyze relevance of converting DB and app time stamps to ISO8601.~~  
14. ~~Test Nokogiri replacements [Ox](https://rubygems.org/gems/ox) and [Oga](https://rubygems.org/gems/oga) [Partially done - updater module uses Oga]~~
15. ~~Replaced Rails gems with pure Ruby methods.~~
16. ~~Add Procfile and config.ru~~
17. ~~Deploy alpha version to production environment~~
18. ~~Switch to SSL~~
19. ~~Implement secure cookies~~


###Ideas for 2.0
1. Port PushTorrent to [Volt](https://rubygems.org/gems/volt)?

##### Ruby questions I currently wonder about... 
1. When do instance variables 'die'? Trying to understand the memory usage of Ruby apps...
2. Is it worth it to manually set an instance variable = nil, when no longer in use? Or will Ruby GC do it for me?
3. Why is GC for symbols great? Should I use symbols more and thereby, as a consequence, optimize the memory usage of the app?
4. Will performance and memory utilization improve by replacing Nokogiri with Ox, Oga or even [Curb](https://rubygems.org/gems/curb), in terms of installed gems alone? Not focucing on the performance of the individual gems (Nokogori vs Ox parsing, for instance), but the number, dependencies and size of installed gems.
5. Is it necessary to implement something akin to [referential integrity](https://github.com/orcasnet/activerecord-referential_integrity) for foreign keys in Sequel? Have done check and delete on "zero associations" in Sequel for now.
