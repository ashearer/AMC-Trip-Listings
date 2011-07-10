<?php
// Intended to be called from cron. Warning: sends out to entire Boston YM
// mailing list without manual confirmation!
// by Andrew Shearer 2006-04
ini_set('display_errors', true);
ini_set('error_reporting', E_ALL);
require_once('formatListings.inc.php');
require_once('sendMail.inc.php');
require_once('sendDadaMail.inc.php');
require_once(dirname(__FILE__).'/../secretConfig.inc.php');

if (!empty($_SERVER['REMOTE_ADDR'])) {
    die('Error: access to this script is denied.');
}
$groupID = 'bostonym';
$groupData = getAMCGroupData($groupID);
$xslDir = dirname(dirname(__FILE__)).DIRECTORY_SEPARATOR;
//chdir('..');
$xslPath = $xslDir.'amc-trips-to-html-email.xsl';
$xslParams = array();
$messageHTML = formatListings($groupID, $xslPath, $xslParams); //$xsl->transformToXML($xml);
$messagePlainText = str_replace(array('–', '↓', '\n\n\n'), array('-', '', '\n\n'), strip_tags($messageHTML));

$subject = $groupData['title'].' Trip Listings';
$from = 'amc2006@shearersoftware.com';
$replyTo = 'amc2006@shearersoftware.com';
$to = '';
$dadaMailURL = 'http://amcboston.org/cgi-bin/dada/mail.cgi';
$dadaMailList = DADAMAIL_LIST;
$dadaMailPassword = DADAMAIL_PASSWORD;
$isTest = false; //true; //!empty($_REQUEST['isTest']);
echo sendDadaMail($subject, $from, $replyTo, $dadaMailURL, $dadaMailList,
    $dadaMailPassword, $messageHTML, $messagePlainText, $isTest);
?>
