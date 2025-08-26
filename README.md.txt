# JSP & MySQL Board System

## 📌 프로젝트 개요
- JSP/Servlet + MySQL로 구현한 **회원 관리 및 게시판 시스템**
- 세션 기반 인증과 데이터 검증을 적용하여 실사용 가능한 구조로 설계

## 🛠 사용 기술
- Java (JSP, Servlet)
- MySQL
- Apache Tomcat
- HTML, CSS, JavaScript

## 🔑 주요 기능
- 회원가입 / 로그인 / 로그아웃 (세션 기반 인증)
- 게시판 CRUD (글쓰기, 조회, 삭제)
- 중복 가입 방지
- 기본 입력값 검증 및 오류 처리

## 🚀 실행 방법
1. MySQL DB 생성 (테이블 구조는 코드/문서 참고)
2. JSP/Servlet 소스코드를 Tomcat 서버에 배포
3. `info.jsp` → 회원가입 → 로그인 → 게시판 기능 사용 가능

## 📂 프로젝트 구조
JSP-BoardSystem/
├─ src/
├─ WebContent/
│ └─ WEB-INF/
│ └─ web.xml
├─ docs/
│ └─ term_project_board.pdf
└─ README.md

## 📄 참고 자료
- [프로젝트 보고서 PDF](./docs/term_project_board.pdf)
