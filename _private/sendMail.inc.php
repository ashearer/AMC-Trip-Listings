<?php
function sendMail($subject, $from, $replyTo, $to, $messageHTML, $messagePlainText) {
    //if (!strlen($message)) $message = '<html><body>'.$message.'</body></html>';

    if (!strlen($from)) $from = 'webserver@'.$_SERVER['SERVER_NAME'];
    $headers = "From: ".$from."\r\n"; 
    //$headers .= "To: ".$to."\r\n"; 
    if (strlen($replyTo)) $headers .= "Reply-To: $replyTo\r\n"; 
    $headers .= "X-Mailer: Hedgehog/PHP\r\n"; 
    
    $useMIME = (strlen($messageHTML) > 0);
    //$message = str_replace("\n", "\r\n", $message);
    if ($useMIME) {
        $boundary = "_--------_".uniqid("HDGHGMAIL"); 
        
        $headers .= 'Content-Type: multipart/alternative; boundary="'.$boundary.'"'."\r\n"; 
        $headers .= "MIME-Version: 1.0\r\n"; 
        $headers .= "\r\n";
        
        // Message for non-MIME-capable email clients
        $mimeBody = "This is a MIME-encoded message.\r\n"; 
        
        /*if (!strlen($messagePlainText)) {
            $messagePlainText = strip_tags($messageHTML);
        }*/
        
        // Plain-text version of message
        if (!strlen($messagePlainText)) {
            $mimeBody .= "\r\n--$boundary\r\n" . 
                "Content-Type: text/plain; charset=UTF-8\r\n" . 
                "Content-Transfer-Encoding: base64\r\n\r\n"; 
            $mimeBody .= chunk_split(base64_encode(strip_tags($messageHTML)));
        }
        else {
            $mimeBody .= "\r\n--$boundary\r\n" . 
                "Content-Disposition: inline\r\n" .
                "Content-Type: text/plain; charset=ISO-8859-1\r\n" . 
                "\r\n".
                $messagePlainText;
        }
        
        // HTML version of message
        $mimeBody .= "\r\n--$boundary\r\n" .
            "Content-Disposition: inline\r\n" .
            "Content-Type: text/html; charset=UTF-8\r\n" .
            "Content-Transfer-Encoding: base64\r\n\r\n"; 
        $mimeBody .= chunk_split(base64_encode($messageHTML)); 
        
        $mimeBody .= "\r\n--$boundary--\r\n";
        $message = $mimeBody;
        
        
        $headers .= $mimeBody;
        $message = '';
    }
    else {
        $headers .= "Content-Type: text/plain; charset=ISO-8859-1\r\n";
        $message = $messagePlainText;
    }
    
    //$message = '';
    //print('To: '.$to.', subject: '.$subject.', message: '.$message.', headers: '.$headers);
    $message = str_replace("\r\n", "\n", $message);
    if (is_array($to)) {
        $to = join($to, ',');
    }
    echo 'sending message of length '.strlen($message.$headers).' to '.$to;
    return mail($to, $subject, $message, $headers);
}
?>