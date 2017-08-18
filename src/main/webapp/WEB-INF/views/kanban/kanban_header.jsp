<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"></c:url>"/>
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"></c:url>">
<link rel="stylesheet" href="<c:url value='/resources/css/kanban.css'></c:url>"/>
<link rel="stylesheet" href="<c:url value='/resources/css/kanbanMain.css'></c:url>"/>
<script src="<c:url value="/resources/js/kanbanMain.js"></c:url>"></script>
<script src="<c:url value="/resources/js/jquery-3.2.1.min.js"></c:url>"></script>
<script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"></c:url>"></script>
<script src="<c:url value="/resources/js/jquery-ui.js"></c:url>"></script>
<jsp:useBean id="now" class="java.util.Date" />

