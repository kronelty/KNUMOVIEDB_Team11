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
    
	String selcgenre = request.getParameter("genre");
    sql = "select AVG(score), r.title, g.genre from rating r, genre_of g where r.title = g.title and g.genre = '"+selcgenre+"' group by r.title, g.genre order by AVG(score) desc";
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
        	if(cnt2==10)break;
	}
	out.println("</table>");
    
	stmt.close();
	rs.close();
	pstmt.close();
	conn.close();
    %>


</body>

</html>