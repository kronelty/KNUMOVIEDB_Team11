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
	PreparedStatement pstmt;
	ResultSet rs;
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
		sql = "select * from MOVIE M where M.title like '%"+title+"%'";
		//���� ����� �˻�������� ����.
		sql +=" AND NOT EXISTS (SELECT * FROM RATING R WHERE M.title=R.title AND R.id='"+id+"')";
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
			String title2 = rs.getString(1);
			%>
			<td style="cursor:pointer;" onClick ="location.href='Movie_Info_Evaluate.jsp?id=<%=id%>&isAdmin=<%=isAdmin%>&title=<%=title2%>'" ><%=title2%></td>
			<%
			String runtime = rs.getString(2);
			if(runtime.equals(""))
				out.println("<td> �˼����� </td>");
			else	
				out.println("<td>"+runtime+"</td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("<td>"+rs.getString(4).substring(0,10)+"</td>");
			out.println("<td>"+rs.getString(5)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
	<%
	stmt.close();
	rs.close();
	pstmt.close();
	conn.close();
    %>
</body>
</html>