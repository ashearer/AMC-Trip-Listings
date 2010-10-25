<?php
/*if ($groupID == 'boston') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015";
    $groupTitle = 'AMC Boston';
    $groupHomePageURL = 'http://amcboston.org/';
}
elseif ($groupID == 'bostonym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2012";
    $groupTitle = 'AMC Boston Young Members';
    $groupHomePageURL = 'http://amcboston.org/youngmembers/';
}
elseif ($groupID == 'worcester') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015";
    //$xmlPath = "http://trips.outdoors.org/xml/Narrtrips.xml";
    $groupTitle = 'AMC Worcester';
    $groupHomePageURL = 'http://amcworcester.org/';
}
elseif ($groupID == 'worcesterym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015";
    $groupTitle = 'AMC Worcester Young Members';
    $groupHomePageURL = 'http://amcworcester.org/ym/';
}
else {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Narragansett&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015";
    $groupID = 'narragansett';
    $groupTitle = 'AMC Narragansett';
    $groupHomePageURL = 'http://amcnarragansett.org/';
}
*/
$kGroupData = array(
    'boston' => array(
        'title' => 'AMC Boston',
        'showHikeRatingKey' => 1,
        'homePageUrl' => 'http://amcboston.org',
        'listingsUrl' => 'http://ashearer.com/amc/listings/?c=boston',
        'rssUrl' => 'http://ashearer.com/amc/listings/?c=boston&output=rss',
        'icsUrl' => 'http://ashearer.com/amc/listings/?c=boston&output=ics',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015',
        ),
    'bostonym' => array(
        'title' => 'AMC Boston Young Members',
        'showHikeRatingKey' => 1,
        'homePageUrl' =>  'http://amcboston.org/youngmembers/',
        'listingsUrl' => 'http://amcboston.org/youngmembers/trip_list.shtml',
        'rssUrl' => 'http://amcboston.org/youngmembers/trips.rss',
        'icsUrl' => 'http://amcboston.org/youngmembers/trips.ics',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015',
        ),
        /*
    'bostonymtemp' => array(
        'title' => 'AMC Boston Young Members',
        'homePageUrl' =>  'http://amcboston.org/youngmembers/',
        'xmlUrl' => 'http://127.0.0.1:8008/amc/listings/bosttrips%20fix.xml',
        ),
        */
    'worcester' => array(
        'title' => 'AMC Worcester',
        'showHikeRatingKey' => 0,
        'homePageUrl' => 'http://amcworcester.org/',
        'listingsUrl' => 'http://ashearer.com/amc/listings/?c=worcester',
        'rssUrl' => 'http://ashearer.com/amc/listings/?c=worcester&output=rss',
        'icsUrl' => 'http://ashearer.com/amc/listings/?c=worcester&output=ics',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015',
        ),
    'worcesterym' => array(
        'title' => 'AMC Worcester Young Members',
        'showHikeRatingKey' => 0,
        'homePageUrl' => 'http://amcworcester.org/ym/',
        'listingsUrl' => 'http://ashearer.com/amc/listings/?c=worcesterym',
        'rssUrl' => 'http://ashearer.com/amc/listings/?c=worcesterym&output=rss',
        'icsUrl' => 'http://ashearer.com/amc/listings/?c=worcesterym&output=ics',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015',
        ),
    'narragansett' => array(
        'title' => 'AMC Narragansett',
        'showHikeRatingKey' => 1,
        'homePageUrl' => 'http://amcnarragansett.org/',
        'listingsUrl' => 'http://ashearer.com/amc/listings/?c=narragansett',
        'rssUrl' => 'http://ashearer.com/amc/listings/?c=narragansett&output=rss',
        'icsUrl' => 'http://ashearer.com/amc/listings/?c=narragansett&output=ics',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Narragansett&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015',
        ),
    'hbboston' => array(
        'title' => 'AMC Boston H/B',
        'showHikeRatingKey' => 1,
        'homePageUrl' => 'http://hbbostonamc.org/',
        'listingsUrl' => 'http://ashearer.com/amc/listings/?c=hbboston',
        'rssUrl' => 'http://ashearer.com/amc/listings/?c=hbboston&output=rss',
        'icsUrl' => 'http://ashearer.com/amc/listings/?c=hbboston&output=ics',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Hiking/Backpacking&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015',
        ),
    'bostonintro' => array(
        'title' => 'AMC Boston Intro',
        'showHikeRatingKey' => 0,
        'homePageUrl' => 'http://amcboston.org/intro/',
        'listingsUrl' => 'http://ashearer.com/amc/listings/?c=bostonintro',
        'rssUrl' => 'http://ashearer.com/amc/listings/?c=bostonintro&output=rss',
        'icsUrl' => 'http://ashearer.com/amc/listings/?c=bostonintro&output=ics',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Intro&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2010&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2015',
        ),

);

function getAMCGroupData($groupID) {
    global $kGroupData;
    if (!isset($kGroupData[$groupID])) {
        $groupID = 'narragansett';
    }
    return $kGroupData[$groupID];
}

function getAMCGroupTitleMap() {
    global $kGroupData;
    $result = array();
    foreach ($kGroupData as $groupID => $groupData) {
        $result[$groupID] = $groupData['title'];
    }
    return $result;
}

function getAMCGroupIDs() {
    global $kGroupData;
    return array_keys($kGroupData);
}


?>
