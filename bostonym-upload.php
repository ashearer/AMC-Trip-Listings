<?php
ini_set('display_errors', true);
ini_set('error_reporting', E_ALL);
// to be added to cron, like:
// 26 * * * * /usr/local/php5/bin/php -q ~/ashearer.com/amc/listings/bostonym-upload.php

require_once('_private/formatListings.inc.php');

//$contentType = 'text/html;charset=UTF-8';

/*
$_SERVER['SERVER_NAME'] = 'amcboston.org';
$_SERVER['SERVER_PORT'] = 80;
*/

$groupID = 'bostonym';
$xslParams = array(
    'listingsURL' => 'http://amcboston.org/youngmembers/trip_list.shtml',
    'rssURL' => 'http://amcboston.org/youngmembers/trips.rss',
    'icsURL' => 'http://amcboston.org/youngmembers/trips.ics');

//$ftp_server = 'amcboston.org';
//$ftp_user_name = ********;
//$ftp_user_pass = '********';
// we first upload to a temp file, then rename, so interrupted uploads
// won't hurt the live site
//doFTPUpload($ftp_server, $ftp_user_name, $ftp_user_pass, $local_file, $destination_file, $destination_temp_file);
//fclose($local_file);

// AMC Boston site setup
$server = 'amcboston.org';
$username = ********;
$userpass = '********';
// AMC Boston site: HTML trip listings page
$xslPath = "amc-trips-to-boston-page.xsl";
$destination_temp_file = 'trip_list_temp.shtml';
$destination_file = 'trip_list.shtml';
makeListingsAndUpload(
    $xslPath, $groupID, $xslParams,
    $server, $username, $userpass,
    $destination_file, $destination_temp_file);
// More AMC Boston site: RSS newsfeed file
$xslPath = "amc-trips-to-rss.xsl";
$destination_temp_file = 'trips.temp.rss';
$destination_file = 'trips.rss';
makeListingsAndUpload(
    $xslPath, $groupID, $xslParams,
    $server, $username, $userpass,
    $destination_file, $destination_temp_file);
// More AMC Boston site: ICS (iCalendar) file
$xslPath = "amc-trips-to-ical.xsl";
$destination_temp_file = 'trips.temp.ics';
$destination_file = 'trips.ics';
makeListingsAndUpload(
    $xslPath, $groupID, $xslParams,
    $server, $username, $userpass,
    $destination_file, $destination_temp_file);

// Google Base
$userpass = '***********';
//$userpass = 'xx';
makeListingsAndUpload(
    'amc-trips-to-rss.xsl', $groupID, $xslParams,
    'uploads.google.com', 'asheareramc', $userpass,
    'amcboston-ym.xml');

function makeListingsAndUpload($xslPath, $groupID, $xslParams,
    $server, $username, $userpass, $destfile, $desttempfile = null) {
    
    $result = formatListings($groupID, $xslPath, $xslParams);
    if (!strlen($result)) {
        die('Error: the XML data could not be formatted for display. Please try again later.');
    }
    doFTPUpload($server, $username, $userpass, $result, $destfile, $desttempfile);
}

/**
 * safe conditional upload of a content string to an FTP server
 * Only uploads the file if the content has changed from what's already on the server;
 * can upload to a temp file first then rename, to avoid having a partial file
 * available to other users during the upload.
 */
function doFTPUpload($ftp_server, $ftp_user_name, $ftp_user_pass, $content, $destination_file, $destination_temp_file = null) {
    // set up basic connection
    $conn_id = ftp_connect($ftp_server);
    if (!$conn_id) {
        die("FTP connection to $ftp_server has failed");
    }
    
    // login with username and password
    if (!ftp_login($conn_id, $ftp_user_name, $ftp_user_pass)) {
        die("FTP login to $ftp_server has failed");
    }
    ftp_pasv($conn_id, true);
    
    $needUpload = true;
    $localReferenceFile = tmpfile();    // download a copy of what's already on the server, so we can see if we need to upload a new version
    if (@ftp_fget($conn_id, $localReferenceFile, $destination_file, FTP_BINARY)) {
        // don't care about errors--if we can't download the existing file, we'll
        // always just upload a new one.
        rewind($localReferenceFile);
        $downloadedContent = '';
        do {
            // read in the file. this has to be done in multiple blocks; fread
            // returned a max of 8K at a time in tests
            $nextBlock = fread($localReferenceFile, strlen($content) + 1 - strlen($downloadedContent));
            $downloadedContent .= $nextBlock;
        } while (strlen($nextBlock) && strlen($downloadedContent) <= strlen($content));
        fclose($localReferenceFile);
        // only bother reading one more byte than the content we're comparing
        // against; this is enough to tell whether the lengths are different, and
        // if not, we can then check whether the content matches. 
        // (We don't have a simple way of checking the length of the
        // tempfile without reading it.)
        if ($downloadedContent == $content) {
            $needUpload = false;    // content is already up there; don't re-upload so we don't change mod date (useful to keep down RSS load)
        }
    }
    //echo "File $destination_file ".($needUpload ? 'DID' : 'DID NOT')." need upload. ";
    
    if ($needUpload) {
        // upload the file
        $local_file = tmpfile();
        fwrite($local_file, $content);
        rewind($local_file);
        if (!ftp_fput($conn_id, strlen($destination_temp_file) ? $destination_temp_file : $destination_file, $local_file, FTP_BINARY)) {
            die("FTP upload to $ftp_server has failed");
        }
        fclose($local_file);
        if (strlen($destination_temp_file)) {
            if (!ftp_rename($conn_id, $destination_temp_file, $destination_file)) {
                die('FTP rename has failed');
            }
        }
        // close the FTP stream 
        ftp_close($conn_id);
    }
}

?>