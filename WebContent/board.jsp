<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="test.ConnectionContext" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script>
	function showTop3(users){
		var msg = "글을 가장 많이 작성한 사용자 TOP3:\n";
		for(var i=0;i<users.length;i++){
			//users배열의 id와 count 속성 가져오기
			msg += (i+1) + "위: " + users[i].id + " (게시글 수: " + users[i].count + ")\n";
		}
		alert(msg);
	}
</script>
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
	//로그인 여부 확인
    String userId = (String) session.getAttribute("userId"); // 로그인한 사용자 ID
    if (userId == null) {
        response.sendRedirect("login.jsp"); // 로그인 페이지(서버) 리다이렉트
        return;
    }
%>

<h1>게시판</h1>
<p>환영합니다, <%= session.getAttribute("userName") %>님!</p>

<form action="post.jsp" method="post">
    <textarea name="content" rows="10" cols="50" placeholder="글 내용을 입력하세요"></textarea>
    <br>
    <button type="submit">글 작성</button>    
</form>

<h2>작성된 글</h2>
<ul id="postList">
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // post_list 테이블에서 데이터 가져오기
        conn = ConnectionContext.getConnection();
        String query = "SELECT id, post FROM post_list"; //게시글 목록 조회
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

        boolean hasPosts = false;
        while (rs.next()) { //게시글이 존재한다면 출력
            hasPosts = true;
%>
            <li data-userid="<%= rs.getString("id") %>">
                <b><%= rs.getString("id") %></b>: <%= rs.getString("post") %>
            </li>
<%
        }

        if (!hasPosts) { //게시글이 없을 경우 메시지 출력
%>
            <p>등록된 게시글이 없습니다.</p>
<%
        }
        rs.close(); //기존 자원 닫기
        pstmt.close();
        String query2 = "SELECT id, COUNT(*) AS post_count " +
        					"FROM post_list " +
        					"GROUP BY id " +
        					"ORDER BY post_count DESC " +
        					"LIMIT 3";
        pstmt = conn.prepareStatement(query2);
        rs = pstmt.executeQuery();
        
        StringBuilder topUsers = new StringBuilder("["); //객체 배열 선언
        boolean first = true; //첫 사용자 이후에 ,로 이후 사용자 구분
        
        while(rs.next()){
        	if(!first){	
        		topUsers.append(", ");
        	}
           topUsers.append("{id: '").append(rs.getString("id")).append("', count: ").append(rs.getInt("post_count")).append("}");
           first = false;
        }
        topUsers.append("]");
 %>
 	<script>
 		var topUsers = <%=topUsers.toString() %>
 		showTop3(topUsers); //alert 문으로 top3 
 	</script>
 <% 
    } catch (Exception e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    }
%>
</ul>
<button onclick="showMyPosts()">내 글 보기</button>

<script>
function showMyPosts() {
    const userId = '<%= userId %>'; // 현재 로그인한 사용자 ID
    const posts = document.querySelectorAll('#postList li'); 
    var myPosts = '';

    posts.forEach(post => {
        if (post.getAttribute('data-userid') === userId) {
        	var content = post.innerText.split(":")[1]?.trim();
            if(content) myPosts += content +'\n';
        }
    });

    if (myPosts) {
        alert('내가 작성한 글:   \n' + myPosts);
    } else {
        alert('내가 작성한 글이 없습니다.');
    }
}

</script>
</body>
</html>
