<?php
ini_set('display_errors', true);
ini_set('error_reporting', E_ALL);
require_once('_private/formatListings.inc.php');
require_once('secretConfig.inc.php');
$status = '';
$groupID = '';
if (isset($_REQUEST['c'])) $groupID = $_REQUEST['c'];
if (!strlen($groupID)) $groupID = 'bostonym';
$groupData = getAMCGroupData($groupID);

$expectedPassword = md5(SENDMAIL_WEB_PASSWORD_SALT.$groupID);
if (!isset($_REQUEST['pw']) || $_REQUEST['pw'] != $expectedPassword) {
    die('Error: incorrect password.');
}

function validateEmail($email) {
    $email = trim($email);
    $validEmail = preg_match('/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,9})+$/', $email);
    if (!$validEmail) {
        die('Error: invalid email address.');
    }
    return $email;
}

if (!empty($_POST['command-preview']) || !empty($_POST['command-send'])) {
    if ($groupID == 'bostonym') {
        $xslPath = 'amc-trips-to-html-email.xsl';
    }
    else {
        $xslPath = 'amc-trips-to-html-email-custom.xsl';
    }
    $xslParams = array();
    if (isset($_REQUEST['mailheader']) && strlen($_REQUEST['mailheader'])) {
        $xslParams['mailheader'] = $_REQUEST['mailheader'];
    }
    $messageHTML = formatListings($groupID, $xslPath, $xslParams); //$xsl->transformToXML($xml);
    $messagePlainText = str_replace(array('–', '↓', '\n\n\n'), array('-', '', '\n\n'), strip_tags($messageHTML));
}
if (!empty($_POST['command-preview'])) {
    echo $messageHTML;
    exit;
}

if (!empty($_POST['command-send'])) {
    require_once('_private/sendMail.inc.php');
    require_once('_private/sendDadaMail.inc.php');
    
    $subject = $groupData['title'].' Trip Listings';
    $from = ''; //'amc-test@lists.ashearer.com';
    $replyTo = ''; //'andrew@ashearer.com';
    $to = ''; //'amc-test@lists.ashearer.com'; //'andrew@ashearer.com';
    
    if (isset($_POST['email']) && strlen($_POST['email'])) {
        $to = validateEmail($_POST['email']);
    }
    $from = validateEmail($_POST['from']);

    //$to = 'shearer.andrew@gmail.com';
    //$from = $to = 'andrew@ashearer.com';
    //echo $messageHTML;print_r(array($subject, $from, $replyTo, $to));
    if (isset($_POST['dadaMailPassword']) && strlen($_POST['dadaMailPassword']) && $groupID == 'bostonym') {
        if (strlen($to)) {
            die('Error: cannot specify both a Dada Mail password and a regular email To address.');
        }
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
        //echo 'From: '.$from.', To: '.$to;
        //echo '<br>';
        //echo $messagePlainText;
        $bcc = '';
        if (!empty($_POST['bcc'])) {
            $bcc = $to;
            $to = '';
        }
        sendMail($subject, $from, $replyTo, $to, $messageHTML, $messagePlainText, $bcc);
    }
    else {
        die('Error: no recipient address or mailing list password specified.');
    }
    
    $status = 'send-success';
}
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
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
if ($status == 'send-success') {
    ?>
    
    <p>Mailing complete.</p>
    <?php
}
else {
    ?>
    <p>This form will send the <?php echo htmlspecialchars($groupData['title']) ?> trip listings to 
    <?php if ($groupID == 'bostonym') {
        ?>
        the Boston YM Dada Mail mailing list<?php
    }
    else {
        ?>
        an email address you provide<?
    }
    ?>.
    
    <!--
    To subscribe to an amc-test list, see the
    <a href="http://lists.ashearer.com/listinfo.cgi/amc-test-ashearer.com">amc-test list page</a>. -->
    </p>
    
    <!--p>If you fill in your email address, it will send the listings just to
    you, instead of the mailing list.</p-->
    
    
    <form action="sendmail.php" method="post">
        <div>
        <label for="mailheader">Header text:</label><br />
        
        <textarea name="mailheader" id="mailheader" rows="10" cols="80"><?php echo nl2br(htmlspecialchars(isset($_REQUEST['mailheader']) ? $_REQUEST['mailheader'] : '')) ?></textarea>
        </div>
        
      Send to email address: <input type="text" size="30" value="<?php echo htmlspecialchars(isset($_REQUEST['email']) ? $_REQUEST['email'] : '') ?>" id="email" name="email" /><br />

      <input type="checkbox" value="1" id="bcc" name="bcc" checked="checked" /> <label for="bcc">Hide Recipient List (Bcc)</label>
      <br />
      
      <?php if ($groupID == 'bostonym') {
        ?>
      To send to Dada Mail instead, enter Dada Mail password: <input type="password" name="dadaMailPassword" size="10" /><br />
      
      <input type="checkbox" name="isTest" value="1" checked /><label>Dada Mail Test</label>
        <?php
      }
      ?>
      
      <input type="hidden" name="c" value="<?php echo htmlspecialchars($groupID) ?>" />
      <input type="hidden" name="pw" value="<?php echo htmlspecialchars($_REQUEST['pw']) ?>" />
      <input type="hidden" name="from" value="<?php echo htmlspecialchars(isset($_REQUEST['from']) ? $_REQUEST['from'] : '') ?>" />
      <input type="submit" value="Preview" name="command-preview" />
      <input type="submit" value="Send Mail" name="command-send" />
    </form>
    
    <?php
}
?>
</body>
</html>
