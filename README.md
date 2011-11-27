# AMC Trip Listings #

This is the code used to format the trip listings for several chapters
of the Appalachian Mountain Club, publishing updates regularly to the web
and sending a weekly HTML and text email to several thousand recipients.

You can see sample output at the [AMC Boston Young Members Trip Listings](http://amcboston.org/youngmembers/trip_list.shtml).

It also outputs iCalendar format files and RSS feeds, so you can subscribe
to see a chapter’s trip listings in your calendar or in a newsreader.

It’s been sending out regular emails and publishing trip listings since 2004,
with some maintenance to keep up with changes to the source trip format.

As sample code, it demonstrates:

 * Complex formatting with XSLT, including grouping using the Muenchian method.

 * Date formatting with EXSLT.

 * Server-side caching of a dynamically generated page.

 * Automated FTP and SFTP uploads of a dynamically-generated file from a PHP script.

 * Generating an HTML email.

 * XSLT code to create an RSS feed.
 
 * XSLT code to create an iCalendar file.

 * Automation of DadaMail, a program designed for manual one-off mailings,
by simulating a browser user. (DadaMail was the available mailing list software on the
server, and sending mail through it lets us take advantage of its list
management, rate-limited batching, and reporting.)

## License ##

BSD 2-clause license. See LICENSE file.


## Contact ##

Find this [project on GitHub](https://github.com/ashearer/AMC-Trip-Listings).

Written by Andrew Shearer. [Email](ashearerw@shearersoftware.com) / [Web site](http://www.ashearer.com/).


