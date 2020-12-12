<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>


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
	PreparedStatement pstmt;
	//ResultSet rs;
	String sql = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	conn.setAutoCommit(false);
	stmt = conn.createStatement();
	
	String id = request.getParameter("id");
	String pw1 = request.getParameter("pw1");
	String pw2 = request.getParameter("pw2");
	
	if(pw1.equals(pw2)){
	sql = "UPDATE ACCOUNT SET PW = '"+pw1+"' WHERE ID='"+id+"'";
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	conn.commit();
	out.println("Password Changed.");
	%> 
	<a href="start.html">Go to home</a>
	<% 
	pstmt.close();
	}else{
		out.println("PW and PW_confirm should be same.");
		%>
			<a href="info.jsp?id=<%=id%>">Go to Info.</a>
		<%
	}
	stmt.close();
	//rs.close();
	conn.close();
	%>
</body>
</html>