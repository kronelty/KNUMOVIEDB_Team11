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
String sql;
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url,user,pass);

conn.setAutoCommit(false);
stmt = conn.createStatement();
%>
<%
String type, start_year,titleName, title;
String runtime;
title = request.getParameter("title");
type = request.getParameter("type");
start_year = request.getParameter("start_year");
titleName = request.getParameter("titleName");
runtime = request.getParameter("runtime");

sql = "UPDATE MOVIE SET type=?, start_year=?, titleName=?, runtime=? WHERE title=?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,type);
pstmt.setString(2,start_year);
pstmt.setString(3,titleName);
pstmt.setString(4,runtime);
pstmt.setString(5,title);
pstmt.executeUpdate();

out.println("MOVIE UPDATED.");
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