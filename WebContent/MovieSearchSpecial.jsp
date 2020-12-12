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
    String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn = null;
	Statement stmt = null;
	//PreparedStatement pstmt;
	//ResultSet rs;
	String sql=null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	conn.setAutoCommit(false);
	stmt = conn.createStatement();
    %>
    <%
	String id = request.getParameter("id");
	int isAdmin = Integer.parseInt(request.getParameter("isAdmin"));

	%>
	
	<div class="nav">
      		<div class="title">Knu Movie DB</div>
      		<div class="nav-right-items">
        		
	<%
		//관리자인지 아닌지 체크하기
		if(isAdmin == 1)// 관리자
		{
			%>
			<div class="admin">
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
		<h2>특정조건 검색하기</h2>
		<form action="MovieSearchSpecial2.jsp?id=<%=id%>&isAdmin=<%=isAdmin%>" method="post">
			타입 type <br/>
			 <select name="type">
				<option value="movie">movie</option>
				<option value="tvSeries">tvSeries</option>
				<option value="knuMovieDbOriginal">knuMovieDbOriginal</option>
			</select> <br/><br/>
			장르 genre <br/>
			<select name="genre">
				<option value="Action">Action</option>
				<option value="Adult">Adult</option>
				<option value="Adventure">Adventure</option>
				<option value="Animation">Animation</option>
				<option value="Biography">Biography</option>
				<option value="Comedy">Comedy</option>
				<option value="Crime">Crime</option>
				<option value="Documentary">Documentary</option>
				<option value="Drama">Drama</option>
				<option value="Family">Family</option>
				<option value="Fantasy">Fantasy</option>
				<option value="Film-Noir">Film-Noir</option>
				<option value="Game-Show">Game-Show</option>
				<option value="History">History</option>
				<option value="Horror">Horror</option>
				<option value="Music">Music</option>
				<option value="Musical">Musical</option>
				<option value="Mystery">Mystery</option>
				<option value="News">News</option>
				<option value="Reality-TV">Reality-TV</option>
				<option value="Romance">Romance</option>
				<option value="Sci-Fi">Sci-Fi</option>
				<option value="Short">Short</option>
				<option value="Sport">Sport</option>
				<option value="Talk-Show">Talk-Show</option>
				<option value="Thriller">Thriller</option>
				<option value="War">War</option>
				<option value="Western">Western</option>
			</select> <br/><br/> 
			국가 country	<br/>
			<select name="country">
				<option value="US">US</option>
				<option value="TW">TW</option>
				<option value="PH">PH</option>
				<option value="FR">FR</option>
				<option value="AR">AR</option>
				<option value="KR">KR</option>
				<option value="GR">GR</option>
				<option value="HU">HU</option>
				<option value="BG">BG</option>
				<option value="DE">DE</option>
				<option value="HK">HK</option>
				<option value="CO">CO</option>
				<option value="RO">RO</option>
				<option value="RU">RU</option>
				<option value="GB">GB</option>
				<option value="UA">UA</option>
				<option value="CU">CU</option>
				<option value="JP">JP</option>
				<option value="PL">PL</option>
			</select>
			<button type="submit">검색하기</button>
		</form>
	</div>
	
    <%
	stmt.close();
	//rs.close();
	//pstmt.close();
	conn.close();
    %>
</body>
</html>