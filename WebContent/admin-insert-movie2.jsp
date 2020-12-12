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
<div class="nav">
      <div class="title">Knu Movie DB</div>
</div>
<%
String serverIP = "localhost";
String strSID = "orcl";
String portNum = "1521";
String user = "university";
String pass = "comp322";
String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;

Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt;
ResultSet rs;
String sql=null;
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url,user,pass);

conn.setAutoCommit(false);
stmt = conn.createStatement();

String type, runtime, startYear, title, titleName;
String [] genre;
String [] country;
String [] actorName;

//1. Movie insert
type = request.getParameter("type");
title = request.getParameter("title");
runtime = request.getParameter("runtime");
startYear = request.getParameter("startYear");
titleName = request.getParameter("titleName");
sql = "insert into MOVIE VALUES ('"+title+"', '"+type+"', '"+runtime+"', '"+startYear+"', '"+titleName+"')";
int res = stmt.executeUpdate(sql);
if(res==1)
{
	out.println("MOVIE INSERT SUCCESS.\n");
	
	
	//2. GENRE_OF insert
	genre = request.getParameterValues("genre");
	if(genre != null)
	{
		for(int i=0;i<genre.length;i++)
		{
			sql = "insert into GENRE_OF VALUES ('"+title+"', '"+genre[i]+"')";
			res = stmt.executeUpdate(sql);
			if(res==1){
				;
			}else{
				out.println("GENRE_OF INSERT ERROR!!!");
			}
		}
		out.println("GENRE_OF INSERT SUCCESS.\n");
		
		//3. VERSION insert
		country = request.getParameterValues("country");
		if(country != null)
		{
			for(int i=0;i<country.length;i++)
			{
				sql = "insert into VERSION VALUES ('"+title+"', '"+country[i]+"')";
				res = stmt.executeUpdate(sql);
				if(res==1){
					;
				}else{
					out.println("VERSION INSERT ERROR!!!");
				}
			}
			out.println("VERSION INSERT SUCCESS.\n");
			//4. ACT_ON insert
			actorName = request.getParameterValues("actorName");
			if(actorName!=null)
			{
				for(int i=0;i<actorName.length;i++)
				{
					sql = "insert into ACT_ON VALUES ('"+title+"', '"+actorName[i]+"')";
					res = stmt.executeUpdate(sql);
					if(res==1){
						;
					}else{
						out.println("ACT_ON INSERT ERROR!!!");
					}
				}
				out.println("ACT_ON INSERT SUCCESS.\n");
			}
			else
			{
				out.println("ACTOR 선택이 부족합니다.");
			}
		}
		else
		{
			out.println("COUNTRY 선택이 부족합니다.");
		}
	}
	else
	{
		out.println("GENRE 선택이 부족합니다.");
	}
}
else
{
	out.println("MOVIE INSERT ERROR!!!");
}

%>
	<a href="start.html">Go to home.</a>
<%
conn.commit(); // 커밋.

stmt.close();
//rs.close();
//pstmt.close();
conn.close();
%>
</body>
</html>