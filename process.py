#!/usr/bin/python
import sys, fileinput, re, os

r = [
     # Basic HTML entities
     
     (re.compile("&"), "&amp;"),
     (re.compile("<"), "&lt;"),
     
     # Paragraphs -- disabled
     #(re.compile(r"\n\n"), r"</p>\n<p>"),
     
     # Trips with a difficulty rating
     (re.compile(r"\n\n([^0-9\n]+[0-9]+(?:-[^0-9\n]*[0-9]+)?)\s+([^\n]+\S)\s+\(([A-D]A?[0-5][A-D])\)\s*\n([^\n]+)"),
      r"\n\n<trip>\n<date>\1</date>\n<title>\2</title>\n<rating>\3</rating>\n<desc>\4</desc>\n</trip>"),
     
     # Other trips (without a rating)
     (re.compile(r"\n\n([^0-9\n]+[0-9]+(?:-[^0-9\n]*[0-9]+)?)\s+([^\n]+\S)\s*\n([^\n]+)"),
      r"\n\n<trip>\n<date>\1</date>\n<title>\2</title>\n<desc>\3</desc>\n</trip>"),
      
     # Email addresses
     (re.compile(r"(?:\&lt;|<)?\b(?:mailto:)?([.\w]+@\w+[\._A-Za-z0-9-]+\w)(?:\&gt;|>)?"),
      r'<a href="mailto:\1">\1</a>'),
      
     # Web addresses
     (re.compile(r"(?:\&lt;|<)?\b(?:http://|(?=www.))([\.\?\&\%/_;~A-Za-z0-9-/]+[/_~A-Za-z0-9-/])(?:\&gt;|>)?"),
      r'<a href="http://\1">\1</a>'),
      
     # Headings
     (re.compile(r"SPECIAL NOTICES:"),
      "Special Notices"),
      
     (re.compile(r"\A\W*(\w+)([^<\n]*)\n\n"),
      r'<trips id="\1\2" link="\1">\n\n'),
      
     (re.compile(r"\n\n([A-Za-z]+)([^<\n]*)\n\n"),
      r'\n</trips>\n\n<trips id="\1\2" link="\1">\n\n'),
      
     # Italic Note: lines, delimited by three slashes
     (re.compile(r"\\\\\\(Note: .*?)\\\\\\"),
      r"\n<p><em>\1</em></p>\n"),
     
     # Paragraphs
     (re.compile(r"\n([^<\n]+)(?=\n|\Z)"),
      r'\n\1<br />'),
     (re.compile(r"\n\n([^<][^_]*?)(?:<br />(?=\n\n)|\n?\n?\Z)"),
      r'\n\n<p>\1</p>')
      
     # Italic Note: lines
     #(re.compile(r"\n(Note: .*?)\n"),
     # r"\n<em>\1</em><br />\n"),
     
     ]

prefix = """<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<?xml-stylesheet href="trips-xml-to-html-page.xsl" type="text/xsl"?>
<listing month="January" year="2005">
<printheader>

<p>Young Members invites outdoor enthusiasts to get involved with the
AMC. To subscribe to our YM Events email list, or to view photos and
trip listings online, go to the YM webpage and follow the directions to
subscribe. Our webpage address is www.amcboston.org/youngmembers.</p>

<p>Questions? Want to learn how to get involved? Check out the
Frequently Asked Questions page on the YM website at
www.amcboston.comm/youngmembers/faq.html.  If you has still have
questions or concerns, please contact the YM Chair
(youngmembers@amcboston.org).</p>

<p>To register for any of these trips, please contact L or CL before 9
PM or, preferably, by email.</p>
</printheader>

<mailheader>
<p>Young Members invites outdoor enthusiasts to
get involved with the AMC.</p>

<p>Questions? Want to learn how to get involved? Visit the Young Members
website
(<a href="http://amcboston.org/youngmembers/">http://amcboston.org/youngmembers/</a>)
and check out the Frequently Asked Questions page. If
you still have questions or concerns, please contact the YM Chair (<a
href="mailto:youngmembers@amcboston.org">youngmembers@amcboston.org</a>).</p>

<p>For full descriptions of the trips listed below, including
registration information, visit:
<a href="http://amcboston.org/youngmembers/trip_list.shtml">http://amcboston.org/youngmembers/trip_list.shtml</a>.</p>

<!--P> A text only trip listing, useful for printing or for those with
slower Internet connections, can be found at: <a
href="http://amcboston.org/youngmembers/trip_list_pf.shtml">http://
amcboston.org/youngmembers/trip_list_pf.shtml</a> -->

<p>The trips listed in this email are subject to change, so for the most
up to date list of activities, please check the listings on the website.</p>

<p><i>NOTE: To unsubscribe from this email or to change your email
address, please follow the link at the bottom of this message. To change
your email address, first unsubscribe using the link at the bottom of
this message, and then re-subscribe using the link on the YM home page.
If you experience any problems with the email or web site, please DO NOT
reply to this message. Instead, please contact Andrew at
<a href="mailto:amc2005@shearersoftware.com">amc2005@shearersoftware.com</a>.
Thanks!</i></p>

</mailheader>

<webheader>
<p>Below is a listing of AMC Young Members trips for
approximately the next two months. To sign up for a trip, contact the
leader or co-leader directly by email or telephone (before 9
<small>PM</small> preferred). Keep in mind that with several hundred
members, Young Members trips are very much in demand, and there are
simply not enough leaders to organize them. Wait lists are maintained on
almost all trips, and there is often quite a bit of attrition. For trips
that charge a fee to cover costs, the policies for payment and
cancellation are up to the discretion of the leaders. Generally
speaking, if you must cancel, you will receive a full refund if your
spot can be filled by another participant.</p>
</webheader>"""

suffix = """</trips>\n</listing>\n"""

#os.chdir(os.path.expanduser('~/Documents/2005/amc/2005-01 boston ym listings/pre-test/'))
os.chdir(sys.path[0])

if len(sys.argv) >= 2:
    f = open(sys.argv[1], 'r')
else:
    f = sys.stdin
data = f.read() #fileinput.input().read()
if not data:
    data = open('trip_listings.txt','r').read() #os.path.expanduser('~/Documents/2005/amc/2005-01 boston ym listings/pre-test/raw.txt'), 'r').read()
for pair in r:
    #print data
    data = pair[0].sub(pair[1], data)
sys.stdout = open('trip_listings.xml','w')
sys.stdout.write(prefix)
sys.stdout.write(data)
sys.stdout.write(suffix)







