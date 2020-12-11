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
	
	String nPnum, nName, nAddress, nSex, nBdate, nJob, nMembership_type, id;
	nPnum = request.getParameter("Pnum");
	nName = request.getParameter("name");
	nAddress = request.getParameter("address");
	nSex = request.getParameter("sex");
	nBdate = request.getParameter("Bdate");
	nJob = request.getParameter("job");
	nMembership_type = request.getParameter("membershipType");
	id = request.getParameter("id");
	
	sql = "Update ACCOUNT SET Pnum=?, name=?, address=?, "
			+ "sex=?, Bdate=?, job=?, membership_type=? WHERE ID=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,nPnum);
	pstmt.setString(2,nName);
	pstmt.setString(3,nAddress);
	pstmt.setString(4,nSex);
	pstmt.setString(5,nBdate);
	pstmt.setString(6,nJob);
	pstmt.setString(7,nMembership_type);
	pstmt.setString(8,id);
	pstmt.executeUpdate();
	conn.commit();
	
	out.println("Information changed.");
	%>
		<a href="info.jsp?id=<%=id%>">Go to Info.</a>
	<%	
	stmt.close();
	//rs.close();
	pstmt.close();
	conn.close();
	%>
</body>
</html>