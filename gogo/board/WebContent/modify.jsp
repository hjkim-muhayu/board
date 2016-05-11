<%@ page
language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"
%>

<%@ page import="java.sql.*"%> 

<script language = "javascript">

function modifyCheck()
{
   var form = document.modifyform;
   
   if( !form.password.value )
   {
	    alert( "비밀번호를 적어주세요" );
    form.password.focus();
    return;
   }
   
  if( !form.title.value )
   {
	    alert( "제목을 적어주세요" );
    form.title.focus();
    return;
   }
 
  if( !form.memo.value )
   {
	    alert( "내용을 적어주세요" );
    form.memo.focus();
    return;
   }  
 		form.submit();
}

</script>
 <%
	request.setCharacterEncoding("utf-8");
 
	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://localhost:3306/good";
	String id = "goodid";
	String pass = "goodpw";
	
	String name = "";
	String password = "";
	String title = "";
	String memo = "";
	
	int idx = Integer.parseInt(request.getParameter("idx"));
	int total = Integer.parseInt(request.getParameter("total"));
	
	try {
		
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT USERNAME, PASSWORD, TITLE, MEMO FROM board WHERE id=" + idx;
		ResultSet rs = stmt.executeQuery(sql);

		
		if(rs.next()){
			
			name = rs.getString(1);
			password = rs.getString(2);
			title = rs.getString(3);
			memo = rs.getString(4);
		}
		
		rs.close();
		stmt.close();
		conn.close();
	}catch(SQLException e) {
		out.println( e.toString() );
	}
	
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
<img src="img/total.png"> 글 수 <font color="red"><%=total%></font>
<body>
<div id="board1">
<form name=modifyform method=post action="modify_ok.jsp?idx=<%=idx%>">
<table class="table table-bordered">
	<tr style="background:#FFDC3C">
		<td colspan="3">자유게시판</td>
	</tr>
	<tr>
    	<td align="center">제목</td>
      	<td><input class="form-control" type=text name=title size=50  maxlength=50 value="<%=title%>"></td>
    </tr>
    <tr>
      	<td align="center">이름</td>
      	<td><%=name%><input class="form-control" type=hidden name=name size=50  maxlength=50 value="<%=name%>"></td>
    </tr>
    <tr>
      	<td align="center">비밀번호</td>
      	<td><input class="form-control" type=password name="password" id="pass" size=50  maxlength=50 ></td>
    </tr>
    <tr>
      	<td align="center">내용</td>
      	<td><textarea class="form-control" name=memo cols=50 rows=13><%=memo%></textarea></td>
    </tr>
    <tr align="center">
      	<td colspan="2">
      	<input class="btn btn-default" type="button" value="수정" OnClick="javascript:modifyCheck(), window.location='view.jsp?idx=<%=idx%>&total=<%=total%>'";">
      	<input class="btn btn-default" type=button value="취소" OnClick="javascript:history.back(-1)">
    </tr>
</table>
</form>
</div>
</body>
</html>