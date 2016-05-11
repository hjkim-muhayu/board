<%@ page
language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"
%>

<%@ page import="java.sql.*"%>

<%
	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://localhost:3306/good";
	String id = "goodid";
	String pass = "goodpw";
	
	int idx = Integer.parseInt(request.getParameter("idx"));
	int total = Integer.parseInt(request.getParameter("total"));
	
	try {
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();

		String sql = "SELECT USERNAME, TITLE, MEMO, TIME, HIT FROM board WHERE id=" + idx;
		ResultSet rs = stmt.executeQuery(sql);

		if(rs.next()){
				String name = rs.getString(1);
				String title = rs.getString(2);
				String memo = rs.getString(3);
				String time = rs.getString(4);
				int hit = rs.getInt(5);

				hit++;
%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<style>
	div#board1{width:900px}
</style>
</head>

<div id="board1">
<body>
<img src="img/total.png"> 글 수 <font color="red"><%=total%></font>
<table class="table table-bordered">
	<tr style="background:#FFDC3C">
		<td colspan="3">자유게시판</td>
	</tr>
	<tr>
		<td width=80px>제목</td><td width=600px><%=title%></td><td align="right"><%=time%></td>
	</tr>
	<tr>
		<td width=80px>글쓴이</td><td><%=name%></td><td align="right">조회수 <%=hit%></td>
	</tr>
    <tr>
        <td colspan="3" height="400"><%=memo %></td>
    </tr>
</table>

<%
 	sql = "UPDATE board SET HIT=" + hit + " where id=" +idx;
 	stmt.executeUpdate(sql);
 	rs.close();
 	stmt.close();
 	conn.close();
	 	} 
	}catch(SQLException e){}
%>
<table class="table table-condensed">
     <tr align="center">
      	<td align="left">
      		<input class="btn btn-default" type=button value="목록" OnClick="window.location='list.jsp'"></td>
    	<td width="700px" align="right">
    		<input class="btn btn-default" type=button value="삭제" name=idx OnClick="window.location='delete.jsp?idx=<%=idx%>&total=<%=total%>'">
			<input class="btn btn-default" type=button value="수정" OnClick="window.location='modify.jsp?idx=<%=idx%>&total=<%=total%>'"></td>
    	<td align="right">
    		<input class="btn btn-default" type=button value="글쓰기" OnClick="window.location='write.jsp?idx=<%=idx%>&total=<%=total%>'"></td>
    </tr>
</table>
</div>

</body>
</html>