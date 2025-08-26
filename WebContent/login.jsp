<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="test.ConnectionContext" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>
<%
    // 로그인 요청 처리 (POST 방식일 때만 실행)
    String method = request.getMethod();
    if ("POST".equalsIgnoreCase(method)) {
        // 사용자가 입력한 로그인 정보
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        // 데이터베이스 연결 변수
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionContext.getConnection();

            // 아이디와 비밀번호로 사용자 인증
            String query = "SELECT * FROM members WHERE id = ? AND password = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 로그인 성공 - 세션에 사용자 정보 저장
                session.setAttribute("userId", id);
                session.setAttribute("userName", rs.getString("name")); // 사용자 이름도 저장
%>
                <script>
                    alert("로그인 성공! 환영합니다, <%= rs.getString("name") %>님!");
                    location.href = "board.jsp"; // 게시판으로 이동
                </script>
<%
            } else {
                // 로그인 실패 - 잘못된 아이디 또는 비밀번호
%>
                <script>
                    alert("아이디 또는 비밀번호가 잘못되었습니다.");
                    location.href = "login.jsp";
                </script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace(); // 서버에 오류 로그 출력
%>
            <p>로그인 처리 중 오류가 발생했습니다: <%= e.getMessage() %></p>
<%
        } finally {
            // 데이터베이스 리소스 정리
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        // GET 요청일 경우 로그인 폼 표시 (사용자가 페이지에 처음 접근할 경우)
%>
        <h2>로그인</h2>
        <form action="login.jsp" method="post">
            <label for="id">아이디:</label>
            <input type="text" id="id" name="id" placeholder="아이디를 입력하세요" required>
            <br>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
            <br>
            <button type="submit">로그인</button>
        </form>
        <br>
        <a href="info.jsp">회원가입</a>
<%
    }
%>
</body>
</html>








