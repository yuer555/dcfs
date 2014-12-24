<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=gbk" %>
<html>
<head>
<title></title>
<script type="text/javascript" src="<c:url value='/js/jquery-autocomplete/lib/jquery.js'/>" > </script>
<script type='text/javascript' src="<c:url value='/js/jquery-autocomplete/lib/jquery.bgiframe.min.js'/>" ></script>
<script type='text/javascript' src="<c:url value='/js/jquery-autocomplete/lib/jquery.ajaxQueue.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/jquery-autocomplete/lib/thickbox-compressed.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/jquery-autocomplete/jquery.autocomplete.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/jquery-autocomplete/demo/localdata.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/jquery-autocomplete/demo/main.css'/>" >
<link rel="stylesheet" type="text/css" href="<c:url value='/js/jquery-autocomplete/jquery.autocomplete.css'/>" >
<link rel="stylesheet" type="text/css" href="<c:url value='/js/jquery-autocomplete/lib/thickbox.css'/>" >
	
<script type="text/javascript">
$().ready(function() {

	function log(event, data, formatted) {
		$("<li>").html( !data ? "No match!" : "Selected: " + formatted).appendTo("#result");
	}
	
	function formatItem(row) {
		return row[0] + " (<strong>id: " + row[1] + "</strong>)";
	}
	function formatResult(row) {
		return row[0].replace(/(<.+?>)/gi, '');
	}
	
	$("#suggest1").focus().autocomplete(cities);
	$("#month").autocomplete(months, {
		minChars: 0,
		max: 12,
		autoFill: true,
		mustMatch: true,
		matchContains: false,
		scrollHeight: 220,
		formatItem: function(data, i, total) {
			// don't show the current month in the list of values (for whatever reason)
			if ( data[0] == months[new Date().getMonth()] ) 
				return false;
			return data[0];
		}
	});
	$("#suggest13").autocomplete(emails, {
		minChars: 0,
		width: 310,
		matchContains: "word",
		autoFill: false,
		formatItem: function(row, i, max) {
			return i + "/" + max + ": \"" + row.name + "\" [" + row.to + "]";
		},
		formatMatch: function(row, i, max) {
			return row.name + " " + row.to;
		},
		formatResult: function(row) {
			return row.to;
		}
	});
	$("#singleBirdRemote").autocomplete("search.php", {
		width: 260,
		selectFirst: false
	});
	$("#suggest14").autocomplete(cities, {
		matchContains: true,
		minChars: 0
	});
	$("#suggest3").autocomplete(cities, {
		multiple: true,
		mustMatch: true,
		autoFill: true
	});
	$("#suggest4").autocomplete('search.php', {
		width: 300,
		multiple: true,
		matchContains: true,
		formatItem: formatItem,
		formatResult: formatResult
	});
	$("#imageSearch").autocomplete("images.php", {
		width: 320,
		max: 4,
		highlight: false,
		scroll: true,
		scrollHeight: 300,
		formatItem: function(data, i, n, value) {
			return "<img src='images/" + value + "'/> " + value.split(".")[0];
		},
		formatResult: function(data, value) {
			return value.split(".")[0];
		}
	});
	$("#tags").autocomplete(["c++", "java", "php", "coldfusion", "javascript", "asp", "ruby", "python", "c", "scala", "groovy", "haskell", "pearl"], {
		width: 320,
		max: 4,
		highlight: false,
		multiple: true,
		multipleSeparator: " ",
		scroll: true,
		scrollHeight: 300
	});
	
	
	$(":text, textarea").result(log).next().click(function() {
		$(this).prev().search();
	});
	$("#singleBirdRemote").result(function(event, data, formatted) {
		if (data)
			$(this).parent().next().find("input").val(data[1]);
	});
	$("#suggest4").result(function(event, data, formatted) {
		var hidden = $(this).parent().next().find(">:input");
		hidden.val( (hidden.val() ? hidden.val() + ";" : hidden.val()) + data[1]);
	});
    $("#suggest15").autocomplete(cities, { scroll: true } );
	$("#scrollChange").click(changeScrollHeight);
	
	$("#thickboxEmail").autocomplete(emails, {
		minChars: 0,
		width: 310,
		matchContains: true,
		highlightItem: false,
		formatItem: function(row, i, max, term) {
			return row.name.replace(new RegExp("(" + term + ")", "gi"), "<strong>$1</strong>") + "<br><span style='font-size: 80%;'>Email: &lt;" + row.to + "&gt;</span>";
		},
		formatResult: function(row) {
			return row.to;
		}
	});
	
	$("#clear").click(function() {
		$(":input").unautocomplete();
	});
});

function changeOptions(){
	var max = parseInt(window.prompt('Please type number of items to display:', jQuery.Autocompleter.defaults.max));
	if (max > 0) {
		$("#suggest1").setOptions({
			max: max
		});
	}
}

function changeScrollHeight() {
    var h = parseInt(window.prompt('Please type new scroll height (number in pixels):', jQuery.Autocompleter.defaults.scrollHeight));
    if(h > 0) {
        $("#suggest1").setOptions({
			scrollHeight: h
		});
    }
}

function changeToMonths(){
	$("#suggest1")
		// clear existing data
		.val("")
		// change the local data to months
		.setOptions({data: months})
		// get the label tag
		.prev()
		// update the label tag
		.text("Month (local):");
}
</script>
	
</head>

<body>

<h1 id="banner"><a href="http://bassistance.de/jquery-plugins/jquery-plugin-autocomplete/">jQuery Autocomplete Plugin</a> Demo</h1>

<div id="content">
	
	<form autocomplete="off">
		<p>
			<label>Single City (local):</label>
			<input type="text" id="suggest1" />
			<input type="button" value="Get Value" />
			<input type="button" value="Change Max Items" onclick="changeOptions();" />
			<input type="button" value="Change to Month Data" onclick="changeToMonths();" />
			<input type="button" value="Change scroll height" id="scrollChange" />
		</p>
		<p>
			<label>Month (local):</label>
			<input type="text" id="month" />
			<input type="button" value="Get Value" />
			(Current month is excluded from list)
		</p>
		<p>
			<label>E-Mail (local):</label>
			<input type="text" id="suggest13" />
			<input type="button" value="Get Value" />
		</p>
		<p>
			<label>Single Bird (remote):</label>
			<input type="text" id="singleBirdRemote" />
			<input type="button" value="Get Value" />
		</p>
		<p>
			<label>Hidden input</label>
			<input />
		</p>
		<p>
			<label>Single City (contains):</label>
			<input type="text" id="suggest14" />
			<input type="button" value="Get Value" />
		</p>
		<p>
			<label>Multiple Cities (local):</label>
			<textarea id='suggest3' cols='40' rows='3'></textarea>
			<input type="button" value="Get Value" />
		</p>
		<p>
			<label>Multiple Birds (remote):</label>
			<textarea id='suggest4'></textarea>
			<input type="button" value="Get Value" />
		</p>
		<p>
			<label>Hidden input</label>
			<textarea></textarea>
		</p>
    <p>
			<label>Image search (remote):</label>
			<input type="text" id='imageSearch' />
			<input type="button" value="Get Value" />
		</p>
    <p>
			<label>Tags (local):</label>
			<input type="text" id='tags' />
			<input type="button" value="Get Value" />
		</p>
		<p>
			<label>Some dropdown (&lt;3 IE):</label>
			<select>
				<option value="">Item 12334455</option>
				<option value="2">Item 2</option>
				<option value="3">Item 3</option>
				<option value="4">Item 4</option>
			</select>
		</p>
		
		<input type="submit" value="Submit" />
	</form>
	
	<p>
		<a href="#TB_inline?height=155&width=400&inlineId=modalWindow" class="thickbox">Click here for an autocomplete inside a thickbox window.</a> (this should work even if it is beyond the fold)
	</p>		
	
	<div id="modalWindow" style="display: none;">
                <p>
                        <label>E-Mail (local):</label>
                        <input type="text" id="thickboxEmail" />
                        <input type="button" value="Get Value" />
                </p>
		</div>
		
	<button id="clear">Remove all autocompletes</button>
	
	<a href="search.phps">PHP script used to for remote autocomplete</a>
	
	<h3>Result:</h3> <ol id="result"></ol>

</div>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-2623402-1";
urchinTracker();
</script>
</body>
</html>
