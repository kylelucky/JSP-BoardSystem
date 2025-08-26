<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="test.ConnectionContext" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
</head>
<body>
<div style="text-align: right; margin: 10px;">
    <a href="info.jsp" style="margin-right: 20px;">회원가입</a>
    <a href="login.jsp">로그인</a>
    <% if (session.getAttribute("userId") != null) { %>
        <a href="logout.jsp" style="margin-left: 20px;">로그아웃</a>
    <% } %>
</div>
<hr>

<%
	//세션에서 로그인한 사용자 정보 가져오기
    String userId = (String) session.getAttribute("userId"); // 로그인한 사용자 ID
    String content = request.getParameter("content");       // 게시글 내용

    if (userId == null) { //로그인이 필요하다면
%>
        <script>
            alert("로그인이 필요합니다.");
            location.href = "login.jsp"; // 로그인 페이지로 이동
        </script>
<%
    } else {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // post_list 테이블에 데이터 삽입
            conn = ConnectionContext.getConnection();
            String query = "INSERT INTO post_list (id, post) VALUES (?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);  // 작성자 ID
            pstmt.setString(2, content); // 게시글 내용
            int result = pstmt.executeUpdate();

            if (result > 0) { //게시글 작성 성공
%>
                <script>
                    alert("글 작성이 완료되었습니다!");
                    location.href = "board.jsp"; // 게시판 페이지로 이동
                </script>
<%
            } else { //게시글 작성 실패
%>
                <script>
                    alert("글 작성 중 문제가 발생했습니다.");
                    window.history.back();
                </script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        }
    }
%>
</body>
</html>



