/**
 * myList.jsp의 javascript 파일
 */
$(document).ready(function() {
	var urlLast = getUrl();
	$("select").change(function() {
		var selectSearchOption = $("select option:selected").val();
		if(selectSearchOption == "boardDate"){
			$("#searchNotDate").val("");
			$("#searchNotDate").hide();
			$("input[type='date']").show();
		} else {
			$("input[type='date']").hide();
			$("#searchNotDate").show();
			$("#searchDate").val("");	
		}
	});
		
	var selectedValue = $("select option:selected").val();
	if(selectedValue =="boardDate"){
		$("#searchNotDate").hide();
		$("input[type='date']").show();
	}
});