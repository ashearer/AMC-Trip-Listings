<?php
class timer {
	var $startTimeFracSec, $startTimeSec;
	
	function timer() {
		list($this->startTimeFracSec, $this->startTimeSec) = explode(' ',microtime());
	}
	
	function elapsedTime() {
		list($currentTimeFracSec, $currentTimeSec) = explode(' ',microtime());
		return ($currentTimeSec - $this->startTimeSec) + ($currentTimeFracSec - $this->startTimeFracSec);
	}
}

global $globalTimer;  // in case the include statement that loaded this file was inside a function
$globalTimer = new timer();

function timeMilestone($operation) {
    global $showTimer;
    global $globalTimer;
    global $lastTime;
    
    if ($showTimer) {
        $currentTime = $globalTimer->elapsedTime();
        echo ('<p class="pageGenTime">'.htmlspecialchars($operation).' @ '
            . $currentTime . ' sec.'
            .(isset($lastTime) ? ' (+'.($currentTime - $lastTime).' sec.)' : '')
            .'</p>');
        $lastTime = $currentTime;
    }
}

?>