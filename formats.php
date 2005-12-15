<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<?php
ini_set('display_errors', true);
ini_set('error_reporting', E_ALL);
require_once('_private/HTMLFieldWriter.inc.php');
require_once('_private/config.inc.php');
require_once('_private/APSHTTPUtils.inc.php');

$groupID = getParam('c');
$record = array('c' => $groupID);
$w = new HTMLFieldWriter($record, true);
//print_r(getAMCGroupIDs());
//print_r(getAMCGroupTitleMap());
$groupData = getAMCGroupData($groupID);

$hostPathQuery = $_SERVER['SERVER_NAME']
    .($_SERVER['SERVER_PORT'] != 80 ? ':'.$_SERVER['SERVER_PORT'] : '')
    .'/amc/listings/?c='.urlencode($groupID);
$listingsURL = 'http://' . $hostPathQuery;
$rssURL = $listingsURL . '&output=rss';
$icsURL = $listingsURL . '&output=ics';
$rssSubscriptionURL = 'feed://' . $hostPathQuery . '&output=rss';
$icsSubscriptionURL = 'webcal://' . $hostPathQuery . '&output=ics';

?>

	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>AMC Trip Listings - Subscribe</title>
	<meta name="generator" content="BBEdit 8.2" />
	<link rel="stylesheet" type="text/css" href="/style.css" />
	<link rel="alternate" type="application/rss+xml" href="<?php echo htmlspecialchars($rssURL) ?>" />
	<link rel="alternate" type="text/calendar" href="<?php echo htmlspecialchars($icsURL) ?>" />
</head>
<body>
<h1>Subscribe to AMC Trip Listings</h1>
<form method="get" action="<?php echo htmlspecialchars(getSelfFormAction()) ?>">
<label for="chapterlist">For:&nbsp;</label>

<?php
echo $w->popup('c', getAMCGroupIDs(), getAMCGroupTitleMap(), false, array('id' => 'chapterlist', 'onclick' => 'this.form.submit()'));

?><noscript><input type="submit" value="Go" /></noscript>
</form>

<p>Trips sponsored by <a href="<?php
echo htmlspecialchars($groupData['homePageUrl']) ?>"><?php echo
htmlspecialchars($groupData['title']) ?></a> can be viewed in the regular
<b><a href="<?php echo htmlspecialchars($listingsURL) ?>">trip listings web page</a></b>
or in these other formats</b>.</p>

<h2>As a Calendar</h2>

<p>You can subscribe to see updated events in your calendar program. Any calendar
program that supports the Internet calendar standard iCalendar will work,
including <a href="http://www.apple.com/macosx/features/ical/">Apple iCal</a> and
<a href="http://www.mozilla.org/projects/calendar/">Mozilla Calendar</a>.
After the first prompt to install
the calendar, you can choose to refresh every hour.

<p><b><a href="<?php
echo htmlspecialchars($icsSubscriptionURL) ?>">Subscribe
automatically in your calendar program</a></b>
</p>

<p>
If clicking the link above doesn't automatically subscribe, use the next one.</p>

<p>Alternate link, for manual download or configuration: <a
href="<?php echo htmlspecialchars($icsURL) ?>"><?php echo
htmlspecialchars($icsURL) ?></a>.</p>

<h2>As a Newsfeed</h2>

<p>If you have an RSS newsreader, such as NetNewsWire for Macintosh, FeedDemon
for Windows, or FeedBurner for any platform, you can
subscribe to see trips as they are posted.</p>

<p><b><a href="<?php
echo htmlspecialchars($rssSubscriptionURL) ?>">Subscribe in your newsreader</a></b></p>

<p>If clicking the link above doesn't automatically open your newsreader, you
can set it up with the following newsfeed address: <a
href="<?php echo htmlspecialchars($rssURL) ?>"><?php echo
htmlspecialchars($rssURL) ?></a>.</p>

<?php
if (!empty($_REQUEST['e'])) {
    ?>
<h2>Email (Experimental)</h2>

    <p>To subscribe to the experimental mailing list, see the
    <a href="http://lists.ashearer.com/listinfo.cgi/amc-test-ashearer.com">amc-test page</a>.
    Note that this list is used just for testing. You will get many more emails
    than normal, and you will need to resubscribe
    when testing ends.
    </p>

    
    <?php
}
?>
</body>
</html>
