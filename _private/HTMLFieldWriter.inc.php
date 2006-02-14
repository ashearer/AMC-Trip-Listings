<?php

// 2004-02-24  ashearer  added setPrefix() method
// 2004-03-04  ashearer  added setSubmittable() method
// 2004-06-28  ashearer  send XHTML-compatible tags
// 2004-06-28  ashearer  add 'attributes' parameters, to allow arbitrary
//                       additional HTML tag attributes for form elements
/* 2004-07-14  ashearer  split XHTML functionality to XHTMLFieldWriter,
                         subclassing HTMLFieldWriter. Fix boolean attributes for
                         XHTML compatibility.
   2004-07-23  ?
   2004-08-13  ashearer  XHTML fix for read-only popups; remove 25% expansion hack
                         for text field lengths
   2004-09-24  ashearer  ?
   2004-09-27  ashearer  setEmptyValueHTML method, to override "n/a"
   
*/

class HTMLFieldWriter {
	var $record;
	var $editable;
	var $prefix;
	
	// Constructor parameters:
	//   $record	Array(field1name => field1value, ...)
	//   $editable	boolean indicating whether to generate form elements, vs. static text
	function HTMLFieldWriter(/*const*/ &$record, $editable) {
		$this->record = &$record;
		$this->editable = $editable;
		$this->submittable = true;
		$this->prefix = '';
		$this->emptyTagEnd = '>';   // overrideable for XHTML subclass
		$this->emptyValueHTML = 'n/a';
	}
	
	function setPrefix($newPrefix) {
	    // set a prefix that will be used in internal field names
	    $this->prefix = $newPrefix;
	}
	
	function setSubmittable($isSubmittable) {
	    // if false, the form will never need to be submitted, so we don't have to
	    // include hidden inputs
	    $this->submittable = $isSubmittable;
	}
	
	function setEmptyValueHTML($emptyValueHTML) {
	    $this->emptyValueHTML = $emptyValueHTML;
	}
	
	function getFieldValue($fieldName, $defaultValue = '') {
	    if (isset($this->record[$fieldName])) {
	        return $this->record[$fieldName];
	    }
	    else {
	        return $defaultValue;
	    }
	}
	
	function textField($fieldName, $visibleLength, $maxLength = false, $forceReadOnly = false, $attributes = null) {
		$value = htmlspecialchars($this->getFieldValue($fieldName));
			// bump up size by 25% to compensate for IE5 Mac's shrunken text fields
		//$visibleLength += ($visibleLength + 3)/4;
		return (!$forceReadOnly && $this->editable) ?
			'<input type="text" name="'.htmlspecialchars($this->prefix.$fieldName)
			  .'" size="'.(int)$visibleLength
			   .($maxLength == 0 ? '' : '" maxlength="'.(int)$maxLength)
			  .'" value="'.$value.'"'
			  .($attributes ? $this->_makeAttributes($attributes) : '')
			  .$this->emptyTagEnd
			: $this->hidden($fieldName).(!strlen($value) ? $this->emptyValueHTML : $value);
	}

	function textArea($fieldName, $rows=4, $cols=60, $forceReadOnly = false, $attributes = null) {
		$value = htmlspecialchars($this->getFieldValue($fieldName));
		return (!$forceReadOnly && $this->editable) ?
			'<textarea name="'.htmlspecialchars($this->prefix.$fieldName).'" rows="'.$rows.'" cols="'.$cols
			  .($attributes ? $this->_makeAttributes($attributes) : '')
			  .'">'.$value.'</textarea>'
			: $this->hidden($fieldName).(!strlen($value) ? $this->emptyValueHTML : nl2br($value));
	}

	function dateField($fieldName, $forceReadOnly = false) {
		return $this->textField($fieldName, 10, 0, $forceReadOnly)
		    .((!$forceReadOnly && $this->editable) ? '  (mm/dd/yyyy)' : '');
	}

	function horizRadioButtons($fieldName, /*const*/ &$choiceValues, /*const*/ &$choiceNames, $forceReadOnly = false, $attributes = null)
	{
		$selectedValue = $this->getFieldValue($fieldName);
		if ($forceReadOnly || !$this->editable) {
			// Display a static choice name
			$choiceName = isset($choiceNames[$selectedValue]) ? $choiceNames[$selectedValue] : $selectedValue;
			return $this->hidden($fieldName).htmlspecialchars($choiceName);
		}
		else {
			// Display radio buttons, embedded in a table so that the labels
			// are vertically centered with respect to the buttons
			$fieldNameHTML = htmlspecialchars($this->prefix.$fieldName);
			$result = '<table border="0" cellpadding="0" cellspacing="0"><tr>';
			while (list(,$choice) = each($choiceValues)) {
				$choiceHTML = htmlspecialchars($choice);
				$choiceName = $choiceNames[''.$choice];
				if (!isset($choiceName)) $choiceName = $choice;
				$result .= '<td valign="absmiddle"><input type="radio" name="'.$fieldNameHTML.'"'
					.' value="'.$choiceHTML.'"'.($selectedValue==$choice ? $this->_makeBooleanAttribute('checked', true, ' ') : '')
					.' id="'.$fieldNameHTML.$choiceHTML.'Radio"'
					.($attributes ? $this->_makeAttributes($attributes) : '')
                    .$this->emptyTagEnd.'</td>'
					.'<td valign="absmiddle"><label for="'.$fieldNameHTML.$choiceHTML.'Radio">&nbsp;'
					.htmlspecialchars($choiceName).'</label>&nbsp;&nbsp;</td>';
			}
			$result .= '</tr></table>';
			return $result;
		}
	}

	function genderRadioButtons($fieldName, $forceReadOnly = false, $attributes = null) {
		$choiceValues = Array('M', 'F', '');
		$choiceNames = Array('M' => 'Male', 'F' => 'Female', '' => 'Unknown');
		return $this->horizRadioButtons($fieldName, $choiceValues, $choiceNames, $forceReadOnly, $attributes);
	}

	function booleanRadioButtons($fieldName, $forceReadOnly = false, $attributes = null) {
		$choiceValues = Array(1, 0);
		$choiceNames = Array(0 => 'No', 1 => 'Yes');
		return $this->horizRadioButtons($fieldName, $choiceValues, $choiceNames, $forceReadOnly, $attributes);
	}

	function checkbox($fieldName, $forceReadOnly = false, $attributes = null) {
		$value = $this->getFieldValue($fieldName);
		return (!$forceReadOnly && $this->editable)
			? '<input type="checkbox" name="'
			    .htmlspecialchars($this->prefix.$fieldName).'"'
			    .$this->_makeBooleanAttribute('checked', $value, ' ').' value="1"'
			    .($attributes ? $this->_makeAttributes($attributes) : '')
			    .$this->emptyTagEnd
			: $this->hidden($fieldName).($value ? 'Yes' : 'No');
	}
	
	function month($fieldName, $forceReadOnly = false, $attributes = null) {	// display full month name (in popup or static text), store 1..12
		$value = $this->getFieldValue($fieldName);
		if (!$forceReadOnly && $this->editable) {
			$result = '<select name="'.htmlspecialchars($this->prefix.$fieldName).'"'
			    .($attributes ? $this->_makeAttributes($attributes) : '')
                .'>';
			for ($monthNum = 1; $monthNum <= 12; $monthNum++) {
				$result .= '<option value="'.$monthNum.'"'
				    .$this->_makeBooleanAttribute('selected', $monthNum==$value, ' ').'>'
					.date("M",mktime(0,0,0,$monthNum,1,2000)).'</option>';
			}
			$result .= '</select>';
		}
		else {
			$result = $this->hidden($fieldName)
			    .($value >= 1 && $value <= 12) ? date("M",mktime(0,0,0,$value,1,2000)) : '';
		}
		return $result;
	}
	
	function popup($fieldName, $choiceList, $displayMapping = false, $forceReadOnly = false,
	    $attributes = null) {	// store value from $choiceList; display using $displayMapping (in popup or static text) if provided
		if (is_string($attributes)) {
		    // legacy API support: fifth parameter used to be 'id'
		    $attributes = array('id' => $attributes);
		}
		$value = $this->getFieldValue($fieldName);
		if (!$forceReadOnly && $this->editable) {
		    $result = '';
			$foundSelectedItem = false;
			foreach ($choiceList as $choiceItem) {
			    if ($choiceItem == $value) $foundSelectedItem = true;
				$result .= '<option value="'.htmlspecialchars($choiceItem).'"'
				    .($choiceItem==$value ? $this->_makeBooleanAttribute('selected', true, ' ') : '').'>'
					.htmlspecialchars(($displayMapping && isset($displayMapping[$choiceItem]))
			            ? $displayMapping[$choiceItem]
			            : $choiceItem).'</option>';
			}
			// Always show the currently selected item in the list, even
			// if it's not in the list we were passed. Add a new entry at the beginning.
			if (!$foundSelectedItem) {
			    $result = '<option value="'.htmlspecialchars($value).'"'.$this->_makeBooleanAttribute('selected', true, ' ').'>'
					.htmlspecialchars(($displayMapping && isset($displayMapping[$value]))
			            ? $displayMapping[$value]
			            : $value).'</option>'
			        .$result;
			}
			$result = '<select name="'.htmlspecialchars($this->prefix.$fieldName).'"'
			    .($attributes ? $this->_makeAttributes($attributes) : '')
			    . '>'
			    .$result.'</select>';
		}
		else {
			$result = htmlspecialchars(($displayMapping && isset($displayMapping[$value]))
			    ? $displayMapping[$value]
			    : $value)
			    . $this->hidden($fieldName);
		}
		return $result;
	}
	
	function popupOrText($fieldName, &$choiceList, $displayMapping = false, $forceReadOnly = false,
	    $attributes = null) {	// store value from $choiceList; display using $displayMapping (in popup or static text) if provided
		// Display text only (no popup) if there will only be one popup item
		// Do this by faking $forceReadOnly in this case, then punting to popup()
		
		/*$value = $this->getFieldValue($fieldName);
		if (sizeof($choiceList) == 0 || (sizeof($choiceList) == 1 && $value == $choiceList[0])) {
		    $result = '<input type="hidden" name="'.htmlspecialchars($fieldName)
		        .'" value="'.htmlspecialchars($value).'">';
		    $forceReadOnly = true;
	    }
	    else {
	        $result = '';
	    }*/
	    $forceReadOnly = $forceReadOnly || sizeof($choiceList) == 0
	        || (sizeof($choiceList) == 1 && $this->getFieldValue($fieldName) == $choiceList[0]);
		return $this->popup($fieldName, $choiceList, $displayMapping, $forceReadOnly, $attributes);
	}
	
	function scale1To9NA($fieldName, $forceReadOnly = false) {
		$value = $this->getFieldValue($fieldName);
		if (!$forceReadOnly && $this->editable) {
			$fieldNameHTML = htmlspecialchars($this->prefix.$fieldName);
			$result = '<table border="0" cellpadding="0" cellspacing="0"><tr>';
			for ($i = 1; $i <= 10; $i++) {
				$result .= '<td align="middle"'.($i==10 ? ' width="50"' : '').'>&nbsp;<input type="radio" name="'.$fieldNameHTML.'"'
					.' value="'.$i.'"'.$this->_makeBooleanAttribute('checked', $value==$i, ' ')
					.' id="'.$fieldNameHTML.$i.'Radio">&nbsp;</td>';
			}
			$result .= '</tr><tr>';
			for ($i = 1; $i <= 10; $i++) {
				$result .= '<td align="middle"><label for="'.$fieldNameHTML.$i.'Radio">&nbsp;'
							.($i==10 ? 'N/A' : $i).'&nbsp;</label></td>';
			}
			$result .= '</tr></table>';
			return $result;
		}
		else {
			if ($value == 10) {
				return $this->hidden($fieldName).'N/A';
			}
			else {
				$result = '';
				for ($i = 1; $i <= 9; $i++) {
					$result .= ($i == $value)
									? '<font size="+1" color="red"><b>'.$value.'</b></font>&nbsp;'
									: $i.'&nbsp;';
				}
				$result .= 'N/A';
				return $this->hidden($fieldName).$result;
			}
		}
	}
	
	function hidden($fieldName) {
	    return $this->submittable
	        ? '<input type="hidden" name="'.htmlspecialchars($this->prefix.$fieldName)
		        .'" value="'.htmlspecialchars($this->getFieldValue($fieldName)).'"'.$this->emptyTagEnd
		    : '';
    }
    
    function _makeAttributes(&$attributes) {
        // convert attributes assoc array to string, embeddable in an HTML tag
        $results = '';
        foreach ($attributes as $key => $value) {
            $results .= ' ' . $key . '="' . htmlspecialchars($value) . '"';
        }
        return $results;
    }
    
    function _makeBooleanAttribute($name, $value = true, $prefix = '') {
        return $value ? $prefix.$name : '';
    }

}

class XHTMLFieldWriter extends HTMLFieldWriter {
    function XHTMLFieldWriter(/*const*/ &$record, $editable) {
        parent::HTMLFieldWriter($record, $editable);
        $this->emptyTagEnd = ' />';
    }
    
    function _makeBooleanAttribute($name, $value = true, $prefix = '') {
        // return non-minimized boolean attribute
        return $value ? $prefix . $name . '="' . htmlspecialchars($name) . '"' : '';
    }
}

?>