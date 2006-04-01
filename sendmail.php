<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>AMC Trip Listings Mailer</title>
	<meta name="generator" content="BBEdit 8.2" />
	<link rel="stylesheet" type="text/css" href="/style.css" />
</head>
<body>
<h1>AMC Trip Listings Mailer</h1>
<?php
ini_set('display_errors', true);
ini_set('error_reporting', E_ALL);
if (!empty($_POST['command-send'])) {
    
    require_once('_private/formatListings.inc.php');
    require_once('_private/sendMail.inc.php');
    require_once('_private/sendDadaMail.inc.php');
        
    $groupID = 'bostonym';
    $xslPath = 'amc-trips-to-html-email.xsl';
    $messageHTML = formatListings($groupID, $xslPath); //$xsl->transformToXML($xml);
    $messagePlainText = str_replace(array('–', '↓', '\n\n\n'), array('-', '', '\n\n'), strip_tags($messageHTML));
    
    //include('_private/config.inc.php');
    $groupData = getAMCGroupData($groupID);
    $subject = $groupData['title'].' Trip Listings';
    $from = 'amc-test@lists.ashearer.com';
    $replyTo = 'andrew@ashearer.com';
    $to = 'amc-test@lists.ashearer.com'; //'andrew@ashearer.com';
    
    if (isset($_POST['email']) && strlen($_POST['email'])) {
        $email = trim($_POST['email']);
        $validEmail = preg_match('/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,9})+$/', $email);
        if (!$validEmail) {
            die('Error: invalid email address.');
        }
        $to = $email;
    }

    //$to = 'shearer.andrew@gmail.com';
    //$from = $to = 'andrew@ashearer.com';
    //echo $messageHTML;print_r(array($subject, $from, $replyTo, $to));
    if (isset($_POST['dadaMailPassword']) && strlen($_POST['dadaMailPassword'])) {
        $from = 'amc2006@shearersoftware.com';
        $replyTo = 'amc2006@shearersoftware.com';
        $to = '';
        $dadaMailURL = 'http://amcboston.org/cgi-bin/dada/mail.cgi';
        $dadaMailList = 'YM';
        $dadaMailPassword = $_REQUEST['dadaMailPassword'];
        $isTest = !empty($_REQUEST['isTest']);
        echo sendDadaMail($subject, $from, $replyTo, $dadaMailURL, $dadaMailList,
            $dadaMailPassword, $messageHTML, $messagePlainText, $isTest);
    }
    elseif (strlen($to)) {
        sendMail($subject, $from, $replyTo, $to, $messageHTML, $messagePlainText);
    }
    else {
        die('Error: no recipient address or mailing list password specified.');
    }
    
    ?>
    
    <p>Mailing complete.</p>
    <?php
}
else {
    ?>
    <p>This button will send the Boston trip listings to an email address you
    provide or to the main Dada Mail mailing list (be careful!).
    To subscribe to an amc-test list, see the
    <a href="http://lists.ashearer.com/listinfo.cgi/amc-test-ashearer.com">amc-test list page</a>.
    </p>
    
    <p>If you fill in your email address, it will send the listings just to
    you, instead of the mailing list.</p>
    
    <form action="sendmail.php" method="post">
      Override list, send to email address: <input type="text" size="30" value="" id="email" name="email" /><br />
      Dada Mail Password: <input type="password" name="dadaMailPassword" size="10" /><br />
      <input type="checkbox" name="isTest" value="1" checked /><label>Dada Mail Test</label>
      <input type="submit" value="Send Mail" name="command-send" />
    </form>
    
    <?php
}
?>
</body>
</html>
