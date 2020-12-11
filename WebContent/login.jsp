<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	
    <%
    String serverIP = "1.209.19.42";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "knumovie";
	String pass = "knumovie";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn = null;
	Statement stmt = null;
	//PreparedStatement pstmt;
	ResultSet rs;
	String sql=null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	conn.setAutoCommit(false);
	stmt = conn.createStatement();
    
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    int isAdmin;
	
	sql = "SELECT * FROM ACCOUNT WHERE ID='" + id + "' AND PW='" + pw + "'";
	rs = stmt.executeQuery(sql);
	if(rs.next()) // 로그인 성공
	{%>
	<div class="nav">
      		<div class="title">Knu Movie DB</div>
      		<div class="nav-right-items">
        		
	<%
		//관리자인지 아닌지 체크하기
		isAdmin = rs.getInt(10);
		if(isAdmin == 1)// 관리자
		{
			%><div class="admin">
				<div class="admin-items">관리자모드</div>
          		<div class="admin-items" Onclick="location.href='admin-insert-movie.jsp'" style="cursor:pointer;">영상물 등록</div>
         		<div class="admin-items" Onclick="location.href='admin-update-movie.html'" style="cursor:pointer;">영상물 수정</div>
         	  </div>
         	  <div class="nav-items" Onclick="location.href='admin-evaluation-confirm.jsp'" style="cursor:pointer; color:blue; font-weight:bolder;">모든 평가내역 확인</div>
			<%
		}
		else// 일반회원
		{
			%>
			  <div class="nav-items" Onclick="location.href='evaluation-confirm.jsp?id=<%=id%>'" style="cursor:pointer;">평가내역 확인</div>
			<%
		}
	%>  	<div class="nav-items" Onclick="location.href='info.jsp?id=<%=id%>'" style="cursor:pointer;">내 정보</div>
      		<div class="nav-items" Onclick="location.href='start.html'" style="cursor:pointer;">로그아웃</div>
      		</div>
   		</div>
   		<div class="main">
   			<div class="select">
   			<div class="select-items">
   				<div class="select-items-title">전체 목록 보기</div>
   				<div class="select-items-detail">영상물의 전체 목록을 불러옵니다.</div>
   				<button class="select-items-btton">Click me</button>
   			</div>
   			<div class="select-items">
   				<div class="select-items-title">제목으로 검색</div>
   				<div class="select-items-detail">제목으로 등록된 영상물을 검색합니다.</div>
   				<button class="select-items-btton">Click me</button>
   			</div>
   			<div class="select-items">
   				<div class="select-items-title">특정조건 검색</div>
   				<div class="select-items-detail">특정 조건으로 영상물을 검색합니다. 장르별, 나라별 검색이 가능합니다.</div>
   				<button class="select-items-btton">Click me</button>
   			</div>
   			</div>
   		</div>
   		
   		
	<%	
	}
	else // 로그인 실패
	{
		%>
		<div class="nav">
      		<div class="title">Knu Movie DB</div>
    	</div>
    	<% 
    	out.println("로그인 실패");
    	%>
    	<a href="start.html">Go to home</a>   	
    	<% 
	}
    
	stmt.close();
	rs.close();
	//pstmt.close();
	conn.close();
    %>
</body>
</html>