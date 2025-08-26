<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
<%
    session.invalidate(); // 현재 세션을 무효화하여 로그아웃 처리
%>
<script>
    alert("로그아웃되었습니다."); 
    location.href = "login.jsp"; // 로그인 페이지로 이동
</script>
</body>
</html>