#!/bin/sh
cd "$(dirname "$0")"
xsltproc --novalid --output ./trip_list.shtml ./trips-xml-to-html-page.xsl ./trip_listings.xml
xsltproc --novalid --output ./trip_list_email.html ./trips-xml-to-html-email.xsl ./trip_listings.xml