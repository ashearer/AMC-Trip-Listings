#!/bin/sh
~/Library/Frameworks/xsltproc --novalid --output ./trip_list.shtml ./trips-xml-to-html-page.xsl ./trip_listings.xml
~/Library/Frameworks/xsltproc --novalid --output ./trip_list_email.html ./trips-xml-to-html-email.xsl ./trip_listings.xml