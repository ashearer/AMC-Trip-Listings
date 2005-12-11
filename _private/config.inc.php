<?php
/*if ($groupID == 'boston') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    $groupTitle = 'AMC Boston';
    $groupHomePageURL = 'http://amcboston.org/';
}
elseif ($groupID == 'bostonym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    $groupTitle = 'AMC Boston Young Members';
    $groupHomePageURL = 'http://amcboston.org/youngmembers/';
}
elseif ($groupID == 'worcester') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    //$xmlPath = "http://trips.outdoors.org/xml/Narrtrips.xml";
    $groupTitle = 'AMC Worcester';
    $groupHomePageURL = 'http://amcworcester.org/';
}
elseif ($groupID == 'worcesterym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    $groupTitle = 'AMC Worcester Young Members';
    $groupHomePageURL = 'http://amcworcester.org/ym/';
}
else {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Narragansett&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    $groupID = 'narragansett';
    $groupTitle = 'AMC Narragansett';
    $groupHomePageURL = 'http://amcnarragansett.org/';
}
*/
$kGroupData = array(
    'boston' => array(
        'title' => 'AMC Boston',
        'homePageUrl' => 'http://amcboston.org',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010',
        ),
    'bostonym' => array(
        'title' => 'AMC Boston Young Members',
        'homePageUrl' =>  'http://amcboston.org/youngmembers/',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010',
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
        'homePageUrl' => 'http://amcworcester.org/',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010',
        ),
    'worcesterym' => array(
        'title' => 'AMC Worcester Young Members',
        'homePageUrl' => 'http://amcworcester.org/ym/',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010',
        ),
    'narragansett' => array(
        'title' => 'AMC Narragansett',
        'homePageUrl' => 'http://amcnarragansett.org/',
        'xmlUrl' => 'http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Narragansett&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010',
        )
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