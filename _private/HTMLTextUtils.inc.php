<?php

// 2005-06-22 ashearer Removed simpleViewResultSet, dumpTable. formURLEncode now calls APSHTTPUtils' makeQueryString function.
// 2005-01-14 ashearer formatName: handle mixed-case testing for first and last names separately; lowercase "de", as in "Portia de Rossi"
// 2004-11-05 ashearer formatName: no longer attempt to normalize case if input contains lowercase
// 2004-02-24 ashearer formatAgeInYearsOrMonths function

function formURLEncode(&$dict) {	// formats the hashtable as Web GET args/POST form
	include_once('APSHTTPUtils.inc.php');
	return makeQueryString($dict, null, '');
}

function splitPair($separator, $both) {
	$initialLength = strpos($both, $separator);
	if ($initialLength===false) $initialLength=strlen($both);
	$initialString = substr($both, 0, $initialLength);
	$secondString = substr($both, $initialLength + strlen($separator));
	return array($initialString, $secondString);
}

// Formats names (may be passed in as uppercase-only) nicely, in "Lastname, Firstname" order
function formatName($last, $first) {
	$last = trim($last);
	if (strtoupper($last) === $last) { // no lowercase letters? Then title-case.
        // Title-case the name
        $last = ucwords(strtolower($last));
        
        // Special cases for common prefixes (Mc and Mac): uppercase the next char.
        // don't try to fix single words starting with "St";
        //   the rule would fire for names like "Stevens"
        if (strlen($last) >= 3 && substr($last, 0, 2) == 'Mc') {
            $last{2} = strtoupper($last{2});
        }
        elseif (strlen($last) >= 4 && substr($last, 0, 3) == 'Mac') {
            $last{3} = strtoupper($last{3});
        }
        elseif (substr($last, 0, 3) == 'De ') {
            $last{0} = 'd';
        }
    }
	
	$first = trim($first);
	if (strtoupper($first) === $first) { // no lowercase letters? Then title-case.
        // Title-case the name
        $first = ucwords(strtolower($first));
    }
    
	if (strlen($last) > 0 && strlen($first) > 0) {
		$text = $last . ', ' . $first;	// have both names; use comma
	}
	else {
		$text = $last . $first;			// only have one of them; no comma
	}
	
	return $text; 
}

function formatNameAndAlias($last, $first, $aliasLast, $aliasFirst) {
	$name = formatName($last, $first);
	if (strlen(trim($aliasLast)) > 0 || strlen(trim($aliasFirst)) > 0) {
		$name .= " <i>aka: ".formatName($aliasLast, $aliasFirst)."</i>";
	}
	return $name;
}

function formatAge($birthdate, $suffix = '-year-old') {	// 'YYYY-MM-DD...' => n.'-year-old' (time of day can follow birthdate, but is ignored)
	if ($birthdate) {
		$now = getdate();
		$age = $now['year'] - intval(substr($birthdate, 0, 4));
		$birthmonth = intval(substr($birthdate, 5, 2));
		$birthdayofmonth = intval(substr($birthdate, 8, 2));
		if ($now['mon'] < $birthmonth || ($now['mon'] == $birthmonth && $now['mday'] < $birthdayofmonth)) {
			$age--;	// not the person's birthday yet this year
		}
		$age = $age . $suffix;
	}
	else {
		$age = '';
	}
	return $age;
}

function formatAgeInYearsOrMonths($birthdate, $yearSuffix = '-year-old', $monthSuffix = '-month-old', $newbornText = 'newborn') {	// 'YYYY-MM-DD...' => n.'-year-old' (time of day can follow birthdate, but is ignored)
	if ($birthdate) {
		$now = getdate();
		$months = 12 * ($now['year'] - intval(substr($birthdate, 0, 4)));
		$birthmonth = intval(substr($birthdate, 5, 2));
		$birthdayofmonth = intval(substr($birthdate, 8, 2));
		$months += $now['mon'] - $birthmonth;
		if ($now['mday'] < $birthdayofmonth) {
			$months--;	// not his birthdate yet this month
		}
		if ($months >= 36) {
		    $age = floor($months / 12) . $yearSuffix;
		}
		elseif ($months > 0 && $monthSuffix != null) {
		    $age = $months . $monthSuffix;
		}
		elseif ($months == 0 && $newbornText != null) {
		    $age = $newbornText;
		}
		else {
		    $age = '';
		}
	}
	else {
		$age = '';
	}
	return $age;
}


function formatGender($gender) {	// 'M'|'F'|'U' => 'male'|'female'|''
	if ($gender == 'M') {
		$gender = 'male';
	}
	elseif ($gender == 'F') {
		$gender = 'female';
	}
	else {
		$gender = '';
	}
	return $gender;
}

function formatNumber($number, $pluralNoun, $singularMessage, $zeroMessage = false) {
	if ($zeroMessage !== false && $number == 0) {
		return $zeroMessage;
	}
	elseif ($number == 1) {
		return $singularMessage;
	}
	else {
		// add thousands separators to $number
		$number = (string)$number;
		$decpt = strrpos($number, '.');	// !!! intl. note: only works with period dec. pt
		if ($decpt === false) $decpt = strlen($number);
		while ($decpt > 3) {
			$decpt -= 3;
			$number = substr($number, 0, $decpt) . ',' . substr($number, $decpt);
		}
		return $number . ' ' . $pluralNoun;
	}
}

function formatTimeInMinutes($seconds) {
	$minutes = (int)($seconds / 60);
	if ($minutes < 60) {
		return formatNumber($minutes, 'minutes', '1 minute', 'less than a minute');
	}
	else {
		$hours = (int)($minutes / 60);
		if ($hours < 24) {
			return formatNumber($hours, 'hours', '1 hour');
		}
		else {
			$days = (int)($hours / 24);
			return formatNumber($days, 'days', '1 day');
		}
	}
}

/*function simpleViewResultSet($results) {
	?>
<table border="0" cellpadding="2" cellspacing="0">
  <tr>
    <?php
	for ($i = 0; $i < mysql_num_fields($results); $i++) {
    	?>
	    <th align="left"><?php echo htmlspecialchars(mysql_field_name($results, $i)) ?></th>
	    <?
	}
	?>
  </tr>
	<?php
	$evenRow = false;
	$recsRead = 0;
	while (($record = &mysql_fetch_row($results))) {
		//$record = &$results->row();
		echo ($evenRow ? '  <tr class="evenRow">' : '  <tr class="oddRow">'."\n");
		echo ('    <td valign="top"><pre>'.join("</pre></td>\n    <td valign=\"top\"><pre>",$record).'</pre></td>'."\n");
		echo ('  </tr>'."\n");
		$evenRow = !$evenRow;
		//$results->nextRow();
		$recsRead++;
	}
	//mysql_free_result($testResults);
	?>
</table>
<p><?php echo $recsRead?> record(s) displayed.</p>
<?php
}

function dumpTable($tableName) {
	echo ('<h3>'.$tableName.'</h3>');
	$sql = 'SELECT * FROM '.$tableName;
	$results = mysql_query($sql) or die('Error: the database query failed. '.htmlspecialchars(mysql_error()));
	simpleViewResultSet($results);
	mysql_free_result($results);
}
*/
?>
