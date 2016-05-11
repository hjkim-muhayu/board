<%@ page
language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"
%>

<script language = "javascript">  // 자바 스크립트 시작

function deleteCheck()
  {
   var form = document.deleteform;
   
   if( !form.password.value )
   {
    alert( "비밀번호를 적어주세요" );
    form.password.focus();
    return;
   }
 		form.submit();
  }
 </script>
 <%
 	int idx = Integer.parseInt(request.getParameter("idx"));
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
<%	int total = Integer.parseInt(request.getParameter("total")); %>
<img src="img/total.png"> 글 수 <font color="red"><%=total%></font>

<body>
<div id="board1">
<form name=deleteform method=post action="delete_ok.jsp?idx=<%=idx%>">
<table class="table table-bordered">
	<tr style="background:#FFDC3C">
		<td colspan="3">자유게시판</td>
	</tr>
	<tr>
    	<td align="center">비밀번호</td>
      	<td><input class="form-control" name="password" type="password" size="50" maxlength="100"></td>
    </tr>
    <tr align="center">
      	<td colspan="2">
   			<input class="btn btn-default" type=button value="삭제" OnClick="javascript:deleteCheck();">
       		<input class="btn btn-default" type=button value="취소" OnClick="javascript:history.back(-1)">
    </tr>
</table>
</form>
</table>
</div>
</body> 
</html>