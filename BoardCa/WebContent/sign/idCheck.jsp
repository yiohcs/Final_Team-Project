<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${idCheck == 1}">
<span style="color: red;">이미사용중인 아이디 입니다.</span>
</c:if>
<c:if test="${idCheck == 0 }">
<span style="color: green;">사용가능한 아이디 입니다.</span>
</c:if>
</body>
</html>