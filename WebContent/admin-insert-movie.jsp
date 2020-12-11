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
PreparedStatement pstmt;
ResultSet rs;
String sql=null;
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url,user,pass);

conn.setAutoCommit(false);
stmt = conn.createStatement();
%>
	<div class="nav">
      <div class="title">Knu Movie DB</div>
    </div>
    
    <div class="main">
    	<h3>MOVIE, GENRE, VERSION, ACTOR �Է�</h3>
    	<form action="admin-insert-movie2.jsp" method="POST">
    		���󹰺з�	type <select name="type">
       				 <option value="movie">movie</option>
      				 <option value="tvSeries">tvSeries</option>
      				 <option value="KnuMovieDbOriginal">KnuMovieDbOriginal</option>
     				 </select> <br/>
    		�󿵽ð� runtime <input type="number" name="runtime"/><br/>
    		�󿵳⵵ startYear <input type="text" name="startYear"/><br/>
    		�����ڵ� title <input type="text" name="title"/><br/>
    		���� titleName <input type="text" name="titleName"><br/><br/>
    		�帣 genre <br/>
    		*�ߺ� ���� ����*<br/>
    		<input type="checkbox" name="genre" value="Action">Action
    		<input type="checkbox" name="genre" value="Adult">Adult
    		<input type="checkbox" name="genre" value="Adventure">Adventure
    		<input type="checkbox" name="genre" value="Animation">Animation
    		<input type="checkbox" name="genre" value="Biography">Biography
    		<input type="checkbox" name="genre" value="Comedy">Comedy
    		<input type="checkbox" name="genre" value="Crime">Crime
    		<input type="checkbox" name="genre" value="Documentary">Documentary
    		<input type="checkbox" name="genre" value="Drama">Drama
    		<input type="checkbox" name="genre" value="Family">Family
    		<input type="checkbox" name="genre" value="Fantasy">Fantasy
    		<input type="checkbox" name="genre" value="Film-Noir">Film-Noir
    		<input type="checkbox" name="genre" value="Game-Show">Game-Show
    		<input type="checkbox" name="genre" value="History">History
    		<input type="checkbox" name="genre" value="Horror">Horror
    		<input type="checkbox" name="genre" value="Music">Music
    		<input type="checkbox" name="genre" value="Musical">Musical
    		<input type="checkbox" name="genre" value="Mystery">Mystery
    		<input type="checkbox" name="genre" value="News">News
    		<input type="checkbox" name="genre" value="Reality-TV">Reality-TV
    		<input type="checkbox" name="genre" value="Romance">Romance
    		<input type="checkbox" name="genre" value="Sci-Fi">Sci-Fi
    		<input type="checkbox" name="genre" value="Short">Short
    		<input type="checkbox" name="genre" value="Sport">Sport
    		<input type="checkbox" name="genre" value="Talk-Show">Talk-Show
    		<input type="checkbox" name="genre" value="Thriller">Thriller
    		<input type="checkbox" name="genre" value="War">War
    		<input type="checkbox" name="genre" value="Western">Western<br/><br/>
    		���� country	<br/>
    		*�ߺ� ���� ����(�ּ� 3���̻� �����ϼ���.)*<br/>
    		<input type="checkbox" name="country" value="US">US <br/>
    		<input type="checkbox" name="country" value="TW">TW <br/>
    		<input type="checkbox" name="country" value="PH">PH <br/>
    		<input type="checkbox" name="country" value="FR">FR <br/>
    		<input type="checkbox" name="country" value="AR">AR <br/>
    		<input type="checkbox" name="country" value="KR">KR <br/>
    		<input type="checkbox" name="country" value="GR">GR <br/>
    		<input type="checkbox" name="country" value="HU">HU <br/>
    		<input type="checkbox" name="country" value="BG">BG<br/>
    		<input type="checkbox" name="country" value="DE">DE <br/>
    		<input type="checkbox" name="country" value="HK">HK <br/>
    		<input type="checkbox" name="country" value="CO">CO <br/>
    		<input type="checkbox" name="country" value="RO">RO <br/>
    		<input type="checkbox" name="country" value="RU">RU <br/>
    		<input type="checkbox" name="country" value="GB">GB <br/>
    		<input type="checkbox" name="country" value="UA">UA <br/>
     		<input type="checkbox" name="country" value="CU">CU <br/>
    		<input type="checkbox" name="country" value="JP">JP <br/>
    		<input type="checkbox" name="country" value="PL">PL <br/><br/>
    		
    		����̸�(����)(�������)<br/> 
    		*2�� �̻� üũ�ϼ���*<br/>
    		*���ϴ� ��찡 ������, ������� ���� �ϼ���*<br/>
    		<%
    			sql = "SELECT * FROM actor";
    			pstmt = conn.prepareStatement(sql);
    			rs = pstmt.executeQuery();
    		
    			while(rs.next())
    			{
    			%>
    			<input type="checkbox" name="actorName" value="<%=rs.getString(1)%>"><%=rs.getString(1)%>(<%=rs.getString(2)%>)(<%=rs.getString(3).substring(0,10)%>)<br/>
    			<%
    			}
    		%>
    		<button type="submit">�����ϱ�</button>
    	</form>
    </div>
    
    
<%
stmt.close();
rs.close();
pstmt.close();
conn.close();
%>
</body>
</html>