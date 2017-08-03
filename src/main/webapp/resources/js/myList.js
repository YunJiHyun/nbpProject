/**
 * myList.jsp의 javascript 파일
 */
$(document).ready(function() {
		$("select").focusout(function() {
			var selectSearchOption = $("select[name='searchOption']").val();
			if(selectSearchOption == "boardDate"){
				$("#searchNotDate").hide();
				$("input[type='date']").show();
				
				
			}
			else {
				$("input[type='date']").hide();
				$("#searchNotDate").show();
				
			}
		});
	});