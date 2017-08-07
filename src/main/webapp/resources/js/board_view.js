/**
 * board_view.jsp의 js파일
 */

function getParams() {
	// 파라미터 배열
	var param = new Array();

	var url = decodeURIComponent(location.href);
		url = decodeURIComponent(url);
	 
	var params;
		params = url.substring( url.indexOf('?')+1, url.length );
		params = params.split("&");

	var size = params.length;
	var key, value;
	
	for(var i=0 ; i < size ; i++) {
		key = params[i].split("=")[0];
		value = params[i].split("=")[1];
		param[key] = value;
	}
	return param;	
}
	