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
	ResultSet rs;
	String sql=null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	conn.setAutoCommit(false);
	stmt = conn.createStatement();
    %>
    
    <%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    int isAdmin;
	
	sql = "SELECT * FROM ACCOUNT WHERE ID='" + id + "' AND PW='" + pw + "'";
	rs = stmt.executeQuery(sql);
	if(rs.next()) // �α��� ����
	{
	%>
	<div class="nav">
      		<div class="title">Knu Movie DB</div>
      		<div class="nav-right-items">
        		
	<%
		//���������� �ƴ��� üũ�ϱ�
		isAdmin = rs.getInt(10);
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
   		<div class="main">
   			<div class="select">
   			<div class="select-items">
   				<div class="select-items-title">��ü��� ����</div>
   				<div class="select-items-detail">������ ��ü ����� �ҷ��ɴϴ�.</div>
   				<button class="select-items-btton" style="cursor:pointer;" Onclick="location.href='MovieView.jsp?id=<%=id%>&isAdmin=<%=isAdmin%>'">�ҷ�����</button>
   			</div>
   			<div class="select-items">
   				<div class="select-items-title">�������� �˻�</div>
   				<div class="select-items-detail">�������� ��ϵ� ������ �˻��մϴ�.</div>
   				<button class="select-items-btton" style="cursor:pointer;" Onclick="location.href='MovieSearch.jsp?id=<%=id%>&isAdmin=<%=isAdmin%>'">�˻��ϱ�</button>
   			</div>
   			<div class="select-items">
   				<div class="select-items-title">Ư������ �˻�</div>
   				<div class="select-items-detail">Ư�� �������� ������ �˻��մϴ�. �帣��, ���� �˻��� �����մϴ�.</div>
   				<button class="select-items-btton" style="cursor:pointer;" Onclick="location.href='MovieSearchSpecial.jsp?id=<%=id%>&isAdmin=<%=isAdmin%>'">�˻��ϱ�</button>
   			</div>
   			<%
         sql = "SELECT Score FROM RATING WHERE ID='" + id + "'";
         rs = stmt.executeQuery(sql);
         if(!rs.next())
         { %>
         <div class="select-items">
            	<div class="select-items-title">��ȭ ��õ</div>
            	<div class="select-items-detail">�帣�� ���ø� ��ȭ�� ��õ�ص帳�ϴ�.</div>
            	<form action="recommend.jsp?id=<%=id %>" method="post">
               genre <select name="genre">
               <option value="Action">Action</option>
               <option value="Adult">Adult</option>
               <option value="Adventure">Adventure</option>
               <option value="Animation">Animation</option>
               <option value="Biography">Biography</option>
               <option value="Comedy">Comedy</option>
               <option value="Crime">Crime</option>
               <option value="Documentary">Documentary</option>
               <option value="Drama">Drama</option>
               <option value="Family">Family</option>
               <option value="Fantasy">Fantasy</option>
               <option value="Film-Noir">Film-Noir</option>
               <option value="Game-Show">Game-Show</option>
               <option value="History">History</option>
               <option value="Horror">Horror</option>
               <option value="Music">Music</option>
               <option value="Musical">Musical</option>
               <option value="Mystery">Mystery</option>
               <option value="News">News</option>
               <option value="Reality-TV">Reality-TV</option>
               <option value="Romance">Romance</option>
               <option value="Sci-Fi">Sci-Fi</option>
               <option value="Short">Short</option>
               <option value="Sport">Sport</option>
               <option value="Talk-Show">Talk-Show</option>
               <option value="Thriller">Thriller</option>
               <option value="War">War</option>
               <option value="Western">Western</option>
              </select> <br/>
            <button class="select-items-btton" type="submit">��õ��ȭ</button>
         	</form>
         	</div>
   			</div>	
   		</div>
   		
   		
	<%	
	}}
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
    %>
    <%
	stmt.close();
	rs.close();
	//pstmt.close();
	conn.close();
    %>
</body>
</html>