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
    String serverIP = "1.209.19.42";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "knumovie";
	String pass = "knumovie";
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
    
    String id = request.getParameter("id");
    String Pnum=null, name=null, address=null, sex=null, Bdate=null, job=null, membership_type = null;
    %>
    	<div class="nav">
      <div class="title">Knu Movie DB</div>
      <div class="nav-right-items">
      	<div class="withdraw" Onclick="location.href='delete.jsp?id=<%= id%>'" style="cursor:pointer;">회원탈퇴</div>
      	<div class="nav-items" Onclick="location.href='start.html'" style="cursor:pointer;">로그아웃</div>
      </div>
    </div>
    <%
	sql = "SELECT * FROM ACCOUNT WHERE ID='" + id + "'";
	rs = stmt.executeQuery(sql);
	if(rs.next())
	{
		Pnum = rs.getString(3);
		name = rs.getString(4);
		address = rs.getString(5);
		sex = rs.getString(6);
		Bdate = rs.getString(7).substring(0, 10);
		job = rs.getString(8);
		membership_type=rs.getString(9);
		%>
		<div class="info">
			<div class="info-items">
				<h2>User Information</h2>
				<h4>ID : <%=id %></h4>
				<h4>Pnum : <%=Pnum %></h4>
				<h4>name : <%=name %></h4>
				<h4>address : <%=address %></h4>
				<h4>sex : <%=sex %></h4>
				<h4>Bdate : <%=Bdate %></h4>
				<h4>job : <%=job %></h4>
				<h4>membershipType : <%=membership_type %></h4>
			</div>
			<div class="info-items">
				<div class="changePW">
				<h2>Change Password</h2>
				<form action="changePW.jsp?id=<%=id %>" method="post">
					PW <input type="text" name="pw1"/><br/>
					PW confirm <input type="text" name="pw2"/><br/>
					<button type="submit">비밀번호 변경</button><br/>
				</form>
				</div>
				<div class="changeInfo">
				<h2>Change Information</h2>
				<form action="changeInfo.jsp?id=<%=id %>" method="post">
					Pnum <input type="text" name="Pnum"/><br/>
					name <input type="text" name="name"/><br/>
					address	<input type="text" name="address"/><br/>
					sex <select name="sex">
       				 <option value="M">M</option>
      				 <option value="F">F</option>
     				 </select> <br/>
					Bdate <input type="text" name="Bdate"/><br/>
					job <input type="text" name="job"/><br/>
					membershipType <select name="membershipType">
       				 <option value="Prime">Prime</option>
      				 <option value="Premium">Premium</option>
       	 			<option value="Basic">Basic</option>
     				 </select> <br/>
					<button type="submit">정보 변경</button>
				</form>
				</div>
			</div>
		</div>
		
		<%
	}
    
	stmt.close();
	rs.close();
	//pstmt.close();
	conn.close();
  %>
</body>
</html>