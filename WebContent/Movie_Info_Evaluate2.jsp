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
    %>
    <%
	String id = request.getParameter("id");
	int isAdmin = Integer.parseInt(request.getParameter("isAdmin"));
	String title = request.getParameter("title");
	String score = request.getParameter("score");

	%>
	
	<div class="nav">
      		<div class="title">Knu Movie DB</div>
      		<div class="nav-right-items">
        		
	<%
		//���������� �ƴ��� üũ�ϱ�
		if(isAdmin == 1)// ������
		{
			%>
			<div class="admin">
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
   		
   		
   	<%
   	sql = "INSERT INTO RATING VALUES ("+score+",'"+title+"','"+id+"')";
   	int res = stmt.executeUpdate(sql);
	if(res==1){
		out.println("�򰡰� �Ϸ�Ǿ����ϴ�.");
	}else{
		out.println("VERSION INSERT ERROR!!!");
	}
   	%>
	<a href="start.html">Go to home.</a>
    <%
    conn.commit();
	stmt.close();
	//rs.close();
	//pstmt.close();
	conn.close();
    %>
</body>
</html>