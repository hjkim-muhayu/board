<%@ page
language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"
%>

<%@ page import="java.sql.*"%>

<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date"%>

<%
	final int ROWSIZE = 12;
	final int BLOCK = 10;

	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int start = (pg*ROWSIZE) - (ROWSIZE-1);
	int end = (pg*ROWSIZE);
	
	int allPage = 0;
	
	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;

%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<style>
	a.pagenum:link {text-decoration: none; color: black;}
	a.pagenum:visited {text-decoration: none; color: black;}
	a.pagenum:active {text-decoration: none; color: black;}
	a.pagenum:hover {text-decoration: underline; color: red;}
	
	a:link {text-decoration: none; color: black;}
	a:visited {text-decoration: none; color: gray;}
	a:active {text-decoration: none; color: black;}
	a:hover {text-decoration: underline; color: black;}
	
	div#board {width:900px}
</style>
</head>

<body>

 <%
	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://localhost:3306/good";
	String id = "goodid";
	String pass = "goodpw";
	
	int total = 0;
	
	try {
		
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		String sql = "";

		
		String sqlCount = "SELECT COUNT(*) FROM board";
		ResultSet rs = stmt.executeQuery(sqlCount);
		
		if(rs.next()){
			total = rs.getInt(1);
		}
		
		int sort=1;
		String sqlSort = "SELECT id from board order by id desc, step asc";
		rs = stmt.executeQuery(sqlSort);
	
		
		while(rs.next()){
			int stepNum = rs.getInt(1);
			sql = "UPDATE board SET STEP=" + sort + " where id=" +stepNum;
		 	stmt1.executeUpdate(sql);
		 	sort++;
		}
		
		allPage = (int)Math.ceil(total/(double)ROWSIZE);
		
		if(endPage > allPage) {
			endPage = allPage;
		}
		
		//out.print("글 수 " + total);
		
		String sqlList = "SELECT ID, USERNAME, TITLE, TIME, HIT FROM BOARD WHERE STEP >= " + start + " AND STEP <= " + end + " ORDER BY STEP asc";
		rs = stmt.executeQuery(sqlList);
		
%>
<div id="board">
<img src="img/total.png"> 글 수 <font color="red"><%=total%></font>
<table class="table table-hover">
	<tr style="background:#FFDC3C">
		<td colspan="5">자유게시판</td>
	</tr>
	<tr style="background:#F2F2F2">
		<td width="70">번호</td>
   		<td width="420">제목</td>
   		<td width="70" align="center">작성자</td>
   		<td width="50" align="center">작성일</td>
   		<td width="50" align="center">조회수</td>
  	</tr>
  
<%
	if(total==0) {
%>
	 	<tr align="center" bgcolor="#FFFFFF" height="30">
	 		<td colspan="6">등록된 글이 없습니다.</td>
	 	</tr>
<%
	 }else{
	 		
		while(rs.next()) {
			int idx = rs.getInt(1);
			String name = rs.getString(2);
			String title = rs.getString(3);
			String time = rs.getString(4);
			int hit = rs.getInt(5);
			
			Date date = new Date();
			
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date Ttime = transFormat.parse(time); // DB에 저장된 string을 Date로 캐스팅 저장
						
			SimpleDateFormat simpleDate1 = new SimpleDateFormat("yyyy-MM-dd"); 
			String year1 = (String)simpleDate1.format(date); // 오늘 년월일
			String yea1 = time.substring(0,10); // DB에 저장된 년월일
			
			SimpleDateFormat simpleDate2 = new SimpleDateFormat("yyyy-MM-dd"); 
			String year2 = (String)simpleDate2.format(Ttime); // 오늘 년월일

			
%>

	<tr>
		<td><%=idx %></td>
		<td align="left"><a href="view.jsp?pg=<%=pg%>&idx=<%=idx%>&total=<%=total%>"><%=title %></a>
<%
			if(year1.equals(yea1)){
				SimpleDateFormat simpleDate3 = new SimpleDateFormat("HH:mm:ss"); 
				year2 = (String)simpleDate3.format(Ttime); // 오늘 년월일
%>				
				<img src='img/new.gif' />
<%
			} 
%>
		</td>
		<td align="left"><%=name %></td>
		<td align="center"><%=year2%></td>
		<td align="center"><%=hit %></td>
	</tr>
<% 
		}
	} 

	rs.close();
	stmt.close();
	conn.close();
}catch(SQLException e){
	//out.println( e.toString() );
}
%>
 
	<tr height="1" bgcolor="#FFFFFF"><td colspan="5"></td></tr>
	</table>
 
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr align="right">
   		<td><input type="button" class="btn btn-default" value="글쓰기" OnClick="window.location='write.jsp?total=<%=total%>'"></td>
  </tr>
  <tr><td colspan="4" height="5"></td></tr>
  <tr>
	<td align="center">
		<%
			if(pg>BLOCK) {
		%>
			<a class="pagenum" href="list.jsp?pg=1">◀◀첫페이지</a>
			<a class="pagenum" href="list.jsp?pg=<%=startPage-1%>">◀이전</a>
		<%
			}
		%>
		
		<%
			for(int i=startPage; i<= endPage; i++){
				if(i==pg){
		%>
					<font color="red"><u><b><%=i %></b></u></font>
		<%
				}else{
		%>
					<a class="pagenum" href="list.jsp?pg=<%=i %>"><%=i %></a>
		<%
				}
			}
		%>
		
		<%
			if(endPage<allPage){
		%>
			<a class="pagenum" href="list.jsp?pg=<%=endPage+1%>">다음▶</a>
			<a class="pagenum" href="list.jsp?pg=<%=allPage%>">끝페이지▶▶</a>
		<%
			}
		%>
		</td>
		</tr>
 </table>
 </div>
 </body> 
</html>