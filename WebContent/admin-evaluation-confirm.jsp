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
    String serverIP = "1.209.19.31";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "knumovie";
	String pass = "knumovie";
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
    
    sql = "select * from rating";
    pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	int cnt2=0;
	out.println("<th>"+ "no" +"</th>");
	for(int i=1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+(++cnt2)+"</td>");
		out.println("<td>"+rs.getInt(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");
    
	stmt.close();
	rs.close();
	pstmt.close();
	conn.close();
    %>
    
    
</body>
</html>