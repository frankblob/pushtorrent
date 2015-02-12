## To-do list for MVP -> Beta -> RC -> 1.0 
### Current Torrent Watch development bugs, issues, features and goals

### UX to-dos
1. Illogical redirect (false return) on "empty string" user input on results view -> redirected to front page.
  * Goal: Should stay on results "page", perhaps with flash error message (Ajax?)
2. Illogical redirect (false return) when user attempts to add a duplicate tracker - > redirected to front page with flash message ("You already have this tracker...").
  * Goal: Should stay on results "page" (Ajax?)

### Roadmap for core functionality / future features
1. Dynamically generate static pages for DB stored trackers (keywords/search terms)
  * Auto-updated site map, with updated child nodes.
2. Develop function for daily querying of trackers
  * Search and update trackers; send email to relevant users
  * Dynamically generate emails when new releases are found (+'buffer' model for interval digests?)
  * Update timedate field for notification, to secure only new releases are searched
3. Email sending. [Pony](https://rubygems.org/gems/pony) gem, gmail smtp, [Sendy](http://sendy.co/), [sendgrid](https://sendgrid.com/) or [campayn](http://campayn.com/)?
  * Generate email template
  * Create example email for hesitant visitors/potential users
4. Develop / install user forum
  * Reuse user DB from app, to avoid double sign up in forum
  * [Discourse](http://www.discourse.org/)?
5. Implement single tracker cration for unregistered users by entering email only + design view/form.
6. Dynamically generated list of 10 latest, most popular and highest seeded notifications, etc. along with 10 most recent forum
  * Cron-job for 10 min interval update of the above, stored in file, to reduce DB querying?
7. Learn and do testing.
8. Swap to PostgreSQL, add [numerical constraints](https://rubygems.org/gems/rein) and [foreign key constraints](https://rubygems.org/gems/foreigner) (for referential integrity) at the database level.
9. Deploy :)

### To-do improvements
1. Check to_time gem necessity and time normalization in app and DB
2. Test Nokogiri replacements [Ox](https://rubygems.org/gems/ox) and [Oga](https://rubygems.org/gems/oga)
3. Redesign the layout - with clear CTA
4. Size and seeder sorted torrent search results.
5. Produce simple instructional video for home page
6. Email [check](https://github.com/mailcheck/mailcheck) & routine
7. Ajax UX improvements
8. Auto-reset of password via pershable token
9. Remember me-functionality
10. Develop user deletion procedure, including associations handling

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

###Ideas for 2.0
1. Port Torrent Watch to [Volt](https://rubygems.org/gems/volt)?