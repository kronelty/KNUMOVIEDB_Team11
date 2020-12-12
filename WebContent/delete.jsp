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
String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

Connection conn = null;
Statement stmt = null;
//PreparedStatement pstmt;
//ResultSet rs;
String sql = null;
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, pass);

conn.setAutoCommit(false);
stmt = conn.createStatement();

String id = request.getParameter("id");
sql = "DELETE FROM ACCOUNT WHERE ID='"+id+"'";
stmt.addBatch(sql);
int[] count = stmt.executeBatch();
if(count.length == 1)
	out.println(id + " deleted.");
conn.commit();
%>
	<a href="start.html">GO to home</a>
<%
//pstmt.close();
stmt.close();
//rs.close();
conn.close();
%>


</body>
</html>