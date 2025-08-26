<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@page import="test.ConnectionContext" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	//사용자가 입력한 데이터 받 
   String id = request.getParameter("id");
   String password = request.getParameter("password");
   String name = request.getParameter("name");
   String ssn1 = request.getParameter("ssn1");
   String ssn2 = request.getParameter("ssn2");
   String gender = request.getParameter("gender");
   
   String ssn = null;
   if(ssn1 != null && ssn2 != null){
      ssn = ssn1.trim() + ssn2.trim(); //주민번호 앞자리 뒷자리 합치기
   }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = ConnectionContext.getConnection(); //디비 연결
       
        //주민번호로 중복 확인
        String checkQuery = "SELECT * FROM members WHERE ssn = ?";
        pstmt = conn.prepareStatement(checkQuery);
        pstmt.setString(1,ssn);
        rs = pstmt.executeQuery();

        //회원가입 된 경우 (중복된 주민번호 있을시)
        if (rs.next()) {
 %>
 
         <script>
                alert("이미 주민등록번호 <%= ssn %>으로 가입된 회원이 있습니다. \n 기존 아이디 <%=rs.getString("id") %>");
                window.history.back(); // 이전 페이지로 돌아가도록 설정
          </script>
<%
        } else {
            // 신규 회원 등록
           String insertQuery = "INSERT INTO members (id,password,name,ssn,gender) VALUES (?,?,?,?,?)";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1,id);
            pstmt.setString(2, password);
            pstmt.setString(3, name);
            pstmt.setString(4, ssn);
            pstmt.setString(5, gender);
           
            int result = pstmt.executeUpdate();
            if(result > 0){ //회원가입 성공
               session.setAttribute("userId", id);
%>            
         <script>
            alert("회원가입이 성공적으로 완료되었습니다!");
            location.href = "login.jsp"; // 로그인 페이지로 이동
         </script>
<%          
         }else{ //회원가입 실패
%>
      <p>회원가입 중 문제가 발생했습니다. 다시 시도하세요. </p>
     
<%
            }
           
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>오류가 발생했습니다: " + e.getMessage() + "</p>");
    } finally {
        // 자원 해제
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>





