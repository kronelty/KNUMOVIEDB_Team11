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
	ResultSet rs;
	String sql=null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	conn.setAutoCommit(false);
	stmt = conn.createStatement();
    %>
    <%
	String id = request.getParameter("id");
	int isAdmin = Integer.parseInt(request.getParameter("isAdmin"));
	String title = request.getParameter("title");

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
	<%
	String sql1 = "SELECT * FROM MOVIE WHERE title='"+title+"'";
	String sql2 = "SELECT * FROM GENRE_OF WHERE title='"+title+"'";
	String sql3 = "SELECT * FROM ACT_ON WHERE title='"+title+"'";
	String sql4 = "SELECT * FROM VERSION WHERE title='"+title+"'";
	String sql5 = "SELECT AVG(SCORE) FROM RATING WHERE title='"+title+"'";

	String type=null,start_year=null,titleName=null;
	int runtime=0;
	rs = stmt.executeQuery(sql1);
	if(rs.next())
	{
		type = rs.getString(2);
		runtime = rs.getInt(3);
		start_year = rs.getString(4).substring(0,10);
		titleName = rs.getString(5);
	}

	String [] genre = new String[20];
	int i=0;
	rs=stmt.executeQuery(sql2);
	while(rs.next())
	{
		genre[i] = rs.getString(2);
		i++;
	}

	i=0;
	String [] actorName = new String[50];
	rs=stmt.executeQuery(sql3);
	while(rs.next())
	{
		actorName[i] = rs.getString(2);
		i++;
	}

	i=0;
	String [] country = new String[20];
	rs=stmt.executeQuery(sql4);
	while(rs.next())
	{
		country[i] = rs.getString(2);
		i++;
	}	
	%>
	<div class="info">
	<div class="info-items">
	<h2>Movie Information</h2>
	<h4>Title : <%=title %></h4>
	<h4>Type : <%=type %></h4>
	<h4>Runtime : <%=runtime %></h4>
	<h4>Start Year : <%=start_year %></h4>
	<h4>TitleName : <%=titleName %></h4>
	<%
		i=0;
		while(genre[i] != null)
		{
			out.println("<h4>Genre["+(i+1)+"] : "+ genre[i] +"</h4>");
			i++;
		}
		
		i=0;
		while(actorName[i] != null)
		{
			out.println("<h4>actorName["+(i+1)+"] : "+ actorName[i] +"</h4>");
			i++;
		}
		
		i=0;
		while(country[i] != null)
		{
			out.println("<h4>country["+(i+1)+"] : "+ country[i] +"</h4>");
			i++;
		}
		String sc=null;
		rs = stmt.executeQuery(sql5);
		if(rs.next()){
			sc = rs.getString(1);
		}
	%>
	</div>
	<div class="info-items">
	<div class="EvaluateMovie">
	<h2>Evaluate Movie</h2>
	<h3>이 영화의 평균 평점은 <%=sc %> 입니다.</h3>
	<h4>*0에 10까지 점수를 매길 수 있습니다*</h4>
	<form action="Movie_Info_Evaluate2.jsp?id=<%=id%>&isAdmin=<%=isAdmin%>&title=<%=title%>" method="post">
	Score <select name="score">
       				 <option value="0">0</option>
      				 <option value="1">1</option>
      				 <option value="2">2</option>
      				 <option value="3">3</option>
      				 <option value="4">4</option>
      				 <option value="5">5</option>
      				 <option value="6">6</option>
      				 <option value="7">7</option>
      				 <option value="8">8</option>
      				 <option value="9">9</option>
      				 <option value="10">10</option>
     	  </select> <br/>
		  <button type="submit">평가하기</button>
	</form>
	</div>
	</div>
	</div>
	
    <%
	stmt.close();
	rs.close();
	//pstmt.close();
	conn.close();
    %>
</body>
</html>