<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<c:set var="path" value="${pageContext.request.contextPath}"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"></c:url>"/>
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"></c:url>"/>
<script src="<c:url value="/resources/js/jquery-3.2.1.min.js"></c:url>"></script>
<script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"></c:url>"></script>
<script src="<c:url value="/resources/js/jquery-ui.js"></c:url>"></script>
<script type="text/javascript" src="../resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<c:url value="/resources/js/map.js"></c:url>"></script>

</head>