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
    String pw = request.getParameter("pw");
    int isAdmin;
	
	sql = "SELECT * FROM ACCOUNT WHERE ID='" + id + "' AND PW='" + pw + "'";
	rs = stmt.executeQuery(sql);
	if(rs.next()) // �α��� ����
	{%>
	<div class="nav">
      		<div class="title">Knu Movie DB</div>
      		<div class="nav-right-items">
        		
	<%
		//���������� �ƴ��� üũ�ϱ�
		isAdmin = rs.getInt(10);
		if(isAdmin == 1)// ������
		{
			%><div class="admin">
				<div class="admin-items">�����ڸ��</div>
          		<div class="admin-items" Onclick="location.href='admin-insert-movie.jsp'" style="cursor:pointer;">���� ���</div>
         		<div class="admin-items" Onclick="location.href='admin-update-movie.html'" style="cursor:pointer;">���� ����</div>
         	  </div>
         	  <div class="nav-items" Onclick="location.href='admin-evaluation-confirm.jsp'" style="cursor:pointer; color:blue; font-weight:bolder;">��� �򰡳��� Ȯ��</div>
			<%
		}
		else// �Ϲ�ȸ��
		{
			%>
			  <div class="nav-items" Onclick="location.href='evaluation-confirm.jsp?id=<%=id%>'" style="cursor:pointer;">�򰡳��� Ȯ��</div>
			<%
		}
	%>  	<div class="nav-items" Onclick="location.href='info.jsp?id=<%=id%>'" style="cursor:pointer;">�� ����</div>
      		<div class="nav-items" Onclick="location.href='start.html'" style="cursor:pointer;">�α׾ƿ�</div>
      		</div>
   		</div>
   		<div class="main">
   			<div class="select">
   			<div class="select-items">
   				<div class="select-items-title">��ü ��� ����</div>
   				<div class="select-items-detail">������ ��ü ����� �ҷ��ɴϴ�.</div>
   				<button class="select-items-btton">Click me</button>
   			</div>
   			<div class="select-items">
   				<div class="select-items-title">�������� �˻�</div>
   				<div class="select-items-detail">�������� ��ϵ� ������ �˻��մϴ�.</div>
   				<button class="select-items-btton">Click me</button>
   			</div>
   			<div class="select-items">
   				<div class="select-items-title">Ư������ �˻�</div>
   				<div class="select-items-detail">Ư�� �������� ������ �˻��մϴ�. �帣��, ���� �˻��� �����մϴ�.</div>
   				<button class="select-items-btton">Click me</button>
   			</div>
   			</div>
   		</div>
   		
   		
	<%	
	}
	else // �α��� ����
	{
		%>
		<div class="nav">
      		<div class="title">Knu Movie DB</div>
    	</div>
    	<% 
    	out.println("�α��� ����");
    	%>
    	<a href="start.html">Go to home</a>   	
    	<% 
	}
    
	stmt.close();
	rs.close();
	//pstmt.close();
	conn.close();
    %>
</body>
</html>