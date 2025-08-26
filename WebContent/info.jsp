<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보 입력</title>
    <style>
        body {
            background-color: skyblue; /*배경색 하늘색으로 설정*/
        }
        form {
            width: 50%;	/*폼의 너비를 페이지의 50%로 설정*/
            margin: auto; /*수평 중앙 정렬*/
            background-color: white; /*폼 배경색 설정*/
            padding: 20px; /*폼 내부의 내용을 감싸는 여백 추가 */
            border-radius: 10px; /*폼의 모서리를 10px로 둥글게 설정 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /*약간의 그림자 효과 추가*/
        }
        table { /*폼 내부의 테이블 스타일*/
            width: 100%;
        }
        td { /*테이블 셀 스타일*/
            padding: 10px;
        }
        button { /*버튼 스타일*/
            margin: 10px;
        }
    </style>
    <script>
    //입력 필드가 비어 있는지 확인하는 함
        function validateField(field, fieldName) {
            if (field.value.trim() === "") {
                alert(fieldName + "을(를) 입력해 주세요.");
                setTimeout(() => field.focus(), 0);
                return false;
            }
            return true;
        }
		//폼 제출 전 전체 검증
        function validateForm() {
            let form = document.forms["registerForm"];
            let fields = ["id", "password", "name", "ssn1", "ssn2"];
            let fieldNames = ["아이디", "비밀번호", "이름", "주민등록번호(앞자리)", "주민등록번호(뒷자리)"];

            // 필수 항목 입력 확인
            for (let i = 0; i < fields.length; i++) {
                let field = form[fields[i]];
                if (field.value.trim() === "") {
                    alert(fieldNames[i] + "을(를) 입력해 주세요.");
                    field.focus();
                    return false;
                }
            }

            // 아이디 형식 확인 (영문자와 숫자만 허용)
            let idPattern = /^[a-zA-Z0-9]+$/;
            if (!idPattern.test(form["id"].value)) {
                alert("아이디는 영문자와 숫자만 입력 가능합니다.");
                form["id"].focus();
                return false;
            }

            return true; // 모든 검사를 통과하면 폼 제출
        }
    </script>
</head>
<body>
    <!-- 네비게이션 바 -->
    <div style="text-align: right; margin: 10px;">
        <a href="info.jsp">회원가입</a>
        <a href="login.jsp">로그인</a>
        <% 
        	//현재 세션에서 userId 값을 가져옴 (로그인 여부 확인)
            String userId = (String) session.getAttribute("userId");
            if (userId != null) { //userId가 세션에 존재하면 로그아웃 버튼 표시
        %>
            <a href="logout.jsp">로그아웃</a>
        <% 
            } 
        %>
    </div>

    <h2 style="text-align: center;">회원 정보 입력</h2>
    <form name="registerForm" action="register.jsp" method="post" onsubmit="return validateForm();">
        <table>
            <tr>
                <td>아이디:</td>
                <td>
                    <input type="text" name="id" placeholder="영문자와 숫자만 입력"
                           onblur="validateField(this, '아이디')">
                </td>
            </tr>
            <tr>
                <td>비밀번호:</td>
                <td>
                    <input type="password" name="password" placeholder="비밀번호 입력"
                           onblur="validateField(this, '비밀번호')">
                </td>
            </tr>
            <tr>
                <td>이름:</td>
                <td>
                    <input type="text" name="name" placeholder="이름 입력"
                           onblur="validateField(this, '이름')">
                </td>
            </tr>
            <tr>
                <td>주민등록번호:</td>
                <td>
                    <input type="text" name="ssn1" maxlength="6" placeholder="앞자리"
                           onblur="validateField(this, '주민등록번호(앞자리)')"> -
                    <input type="text" name="ssn2" maxlength="7" placeholder="뒷자리"
                           onblur="validateField(this, '주민등록번호(뒷자리)')">
                </td>
            </tr>
            <tr>
                <td>성별:</td>
                <td>
                    <input type="radio" name="gender" value="male"> male
                    <input type="radio" name="gender" value="female"> female
                </td>
            </tr>
            <tr>
                <td>취미:</td>
                <td>
                    <input type="checkbox" name="hobby" value="게임"> 게임
                    <input type="checkbox" name="hobby" value="독서"> 독서
                    <input type="checkbox" name="hobby" value="영화감상"> 영화감상
                    <input type="checkbox" name="hobby" value="운동"> 운동
                </td>
            </tr>
            <tr>
                <td>자기 소개:</td>
                <td>
                    <textarea name="intro" rows="5" cols="40"
                              placeholder="자기 소개 입력"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align: center;">
            <button type="submit">등록하기</button>
            <button type="reset">취소하기</button>
        </div>
    </form>
</body>
</html>
