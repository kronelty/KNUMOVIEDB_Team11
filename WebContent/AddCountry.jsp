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
String serverIP = "1.209.19.42";
String strSID = "orcl";
String portNum = "1521";
String user = "knumovie";
String pass = "knumovie";
String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;

Connection conn = null;
Statement stmt = null;
//PreparedStatement pstmt;
//ResultSet rs;
String sql1, sql2, sql3, sql4;
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url,user,pass);

conn.setAutoCommit(false);
stmt = conn.createStatement();
%>

<%
	String title = request.getParameter("title");
	String [] country = request.getParameterValues("country");
	if(country != null)
	{
		for(int i=0;i<country.length;i++)
		{
			String sql = "insert into VERSION VALUES ('"+title+"', '"+country[i]+"')";
			int res = stmt.executeUpdate(sql);
			if(res==1){
				;
			}else{
				out.println("VERSION INSERT ERROR!!!");
			}
		}
		out.println("VERSION INSERT SUCCESS.\n");
	}
	else
	{
		out.println("COUNTRY를 선택하지 않았습니다.");
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