<?php
function sendDadaMail($subject, $from, $replyTo, $url, $list, $password, $htmlBody, $textBody, $isTest = false) { 
    //$url = 'http://amcboston.org/cgi-bin/dada/mail.cgi';
    //$postFields = 'f=login&process=true&admin_list=YM&admin_password=********';
    $postFields = 'f=login&process=true&admin_list='.rawurlencode($list)
        .'&admin_password='.rawurlencode($password);
    //echo $postFields;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL,  $url); 
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postFields);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_COOKIEJAR, '-');
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    $postResult = curl_exec($ch);
    
    if (curl_errno($ch)) {
        print curl_error($ch);
        die;
    }
    
    //echo 'First message:';
    //echo $postResult;
    
    $postFields = 'f=send_email&From='.rawurlencode($from) //"Young%20Members"%20<andrew@ashearer.com>'
        .'&Reply_To='.rawurlencode($replyTo) //"Young%20Members"%20<andrew@ashearer.com>&Precedence=list'
        .'&Priority=3&message_subject='.rawurlencode($subject)
        .'&text_message_body='.rawurlencode($textBody)
        .'&html_message_body='.rawurlencode($htmlBody)
        .'&Start-Email=&Start-Num='
        .'&process='.($isTest ? 'Submit%20Test&20Message' : 'Submit%20Mailing%20List%20Message')
        .'&im_sure=1&new_win=1';
    /*$postFields = array(
        'f' => 'send_email',
        'From' => '"Young Members" <andrew@ashearer.com>',
        'Reply_To' => '"Young Members" <andrew@ashearer.com>',
        'Precedence' => 'list',
        'Priority' => 3,
        'message_subject' => $subject,
        'text_message_body' => $textBody,
        'html_message_body' => $htmlBody,
        'Start-Email' => '',
        'Start-Num' => '',
        'process' => 'Submit Mailing List Message',
        'im_sure' => '1',
        'new_win' => '1'
    );*/
    
    //$ch = curl_init();
    //curl_setopt($ch, CURLOPT_URL,  $url); 
    //curl_setopt($ch, CURLOPT_POST, 1);
    set_time_limit(3600);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postFields);
    curl_setopt($ch, CURLOPT_TIMEOUT, 3600);
    //curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $postResult = curl_exec($ch);
    
    if (curl_errno($ch)) {
        print curl_error($ch);
        die;
    }
    
    //echo 'Second result:';
    //echo $postResult;
    
    curl_close($ch);
    
    return $postResult;
}
