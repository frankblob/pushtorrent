# To-do list
### Current Torrent Watch development bugs, issues, features and goals

### UX to-dos
1.Illogical redirect (false return) on "empty string" user input on results "page" -> redirected to front page. 
  * Goal: Should stay on results "page", perhaps with flash error message.
2. Illogical redirect (false return) when user attempts to add a duplicate tracker - > redirected to front page with flash message ("You already have this tracker...").
  * Goal: Should stay on results "page".

### Known bugs
1. Torrent results listing of MB, seeders and date/time is error-prone and shows "XX Y"  (eg. "68 1") for some torrents with XX (68) seeders and Y (1) leecher.

### Feature to-dos
1. Email sending. Pony gem, gmail smtp, Sendy, sendgrid or campayn?  
2. Generating static pages for DB stored trackers (keywords/search terms)
  * Auto-updated site map
3. Search and update trackers; send email to relevant users.
4. Displaying list of latest trackers, most popular trackers, most seeded trackers.
  * Cron-job for 10 min interval update of the above, stored in file, to reduce DB querying.
5. Enable adding a single tracker for unregistered users by entering email only + design view.
6. Implement fall-back RSS feed

### Improvements
1. Fetch time-sorted feed from URL = 'https://torrentz.eu/feedA?f='
2. Check to_time gem necessity and time normalization in app and DB
3. Test Nokogiri replacements Ox and Oga
