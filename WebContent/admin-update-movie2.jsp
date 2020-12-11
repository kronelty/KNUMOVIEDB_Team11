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
String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;

Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt;
ResultSet rs;
String sql1, sql2, sql3, sql4;
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url,user,pass);

conn.setAutoCommit(false);
stmt = conn.createStatement();
%>

<%
String title = request.getParameter("title");
sql1 = "SELECT * FROM MOVIE WHERE title='"+title+"'";
sql2 = "SELECT * FROM GENRE_OF WHERE title='"+title+"'";
sql3 = "SELECT * FROM ACT_ON WHERE title='"+title+"'";
sql4 = "SELECT * FROM VERSION WHERE title='"+title+"'";

String type=null,start_year=null,titleName=null;
int runtime=0;
rs = stmt.executeQuery(sql1);
if(rs.next())
{
	type = rs.getString(2);
	runtime = rs.getInt(3);
	start_year = rs.getString(4).substring(0,10);
	titleName = rs.getString(5);
}

String [] genre = new String[20];
int i=0;
rs=stmt.executeQuery(sql2);
while(rs.next())
{
	genre[i] = rs.getString(2);
	i++;
}

i=0;
String [] actorName = new String[50];
rs=stmt.executeQuery(sql3);
while(rs.next())
{
	actorName[i] = rs.getString(2);
	i++;
}

i=0;
String [] country = new String[20];
rs=stmt.executeQuery(sql4);
while(rs.next())
{
	country[i] = rs.getString(2);
	i++;
}
%>
<div class="info">
	<div class="info-items">
	<h2>Movie Information</h2>
	<h4>Title : <%=title %></h4>
	<h4>Type : <%=type %></h4>
	<h4>Runtime : <%=runtime %></h4>
	<h4>Start Year : <%=start_year %></h4>
	<h4>TitleName : <%=titleName %></h4>
	<%
		i=0;
		while(genre[i] != null)
		{
			out.println("<h4>Genre["+(i+1)+"] : "+ genre[i] +"</h4>");
			i++;
		}
		
		i=0;
		while(actorName[i] != null)
		{
			out.println("<h4>actorName["+(i+1)+"] : "+ actorName[i] +"</h4>");
			i++;
		}
		
		i=0;
		while(country[i] != null)
		{
			out.println("<h4>country["+(i+1)+"] : "+ country[i] +"</h4>");
			i++;
		}
	%>
	</div>
	<div class="info-items">
		<div class="ChangeMovieInfo">
		<h2>Change Movie Information</h2>
		<form action="ChangeMovieInfo.jsp?title=<%=title %>" method="post">
		Type <select name="type">
       				 <option value="movie">movie</option>
      				 <option value="tvSeries">tvSeries</option>
      				 <option value="KnuMovieDbOriginal">KnuMovieDbOriginal</option>
     				 </select> <br/>
		Runtime <input type="number" name="runtime"/><br/>
		Start Year <input type="text" name="start_year"/><br/>
		Title Name <input type="text" name="titleName"><br/><br/>
		<button type="submit">수정하기</button>
		</form>
		</div>
		<div class="Add Version">
		<h2>Add Country</h2>
		<h3>*이미 존재하는 나라는 선택목록에서 제외되었습니다*</h3>
		<form action="AddCountry.jsp?title=<%=title %>"  method="post">
		<%
    			String sql = "SELECT DISTINCT country FROM VERSION ";
						sql+= " WHERE country NOT IN (select country from VERSION where title='"+title+"')";
    			pstmt = conn.prepareStatement(sql);
    			rs = pstmt.executeQuery();
    			
    			while(rs.next())
    			{
    			%>
    			<input type="checkbox" name="country" value="<%=rs.getString(1)%>"><%=rs.getString(1)%><br/>
    			<%
    			}
    		%>
    	<button type="submit">추가하기</button>
    	</form>
		</div>
	</div>
</div>

<%
conn.commit(); // 커밋.

stmt.close();
rs.close();
pstmt.close();
conn.close();
%>
</body>
</html>