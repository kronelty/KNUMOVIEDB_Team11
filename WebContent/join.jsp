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
	//PreparedStatement pstmt;
	//ResultSet rs;
	String sql=null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	conn.setAutoCommit(false);
	stmt = conn.createStatement();
	
	String id = request.getParameter("id");
	String PW = request.getParameter("PW");
	String Pnum = request.getParameter("Pnum");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String sex = request.getParameter("sex");
	String Bdate = request.getParameter("Bdate");
	String job = request.getParameter("job");
	String membershipType = request.getParameter("membershipType");
	
	sql = "INSERT INTO ACCOUNT values (" + "'" + id + "', " + "'" + PW + "', " + "'" + Pnum + "', "
			+ "'" + name + "', " + "'" + address + "', " + "'" + sex + "', " + "TO_DATE('" + Bdate
			+ "', 'yyyy-mm-dd'), " + "'" + job + "', " + "'" + membershipType + "', " + "0)";
	int res = stmt.executeUpdate(sql);
	if(res==1)
	{
		out.println("Join completed.");
		conn.commit();
	}
	else
	{
		out.println("error occurred.");
	}
	
	stmt.close();
	//rs.close();
	//pstmt.close();
	conn.close();
%>
<a href="start.html">Go to home.</a>

</body>
</html>