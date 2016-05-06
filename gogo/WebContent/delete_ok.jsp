<%@ page
language="java"
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"
%>

<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
Class.forName("com.mysql.jdbc.Driver");

String url = "jdbc:mysql://localhost:3306/good";
String id = "goodid";
String pass = "goodpw";
	String password = null;
	int idx = Integer.parseInt(request.getParameter("idx"));
	String passw = request.getParameter("password");
	
	try{
				
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT PASSWORD FROM board WHERE id=" + idx;
		ResultSet rs = stmt.executeQuery(sql);
		
		 if(rs.next()){
				password = rs.getString(1); 
   }
		  if(password.equals(passw)) {
	   			
				sql = "DELETE FROM board WHERE id=" + idx;	
				stmt.executeUpdate(sql);	 
	%>
	  			<script language=javascript>
	   				self.window.alert("해당 글을 삭제하였습니다.");
	   				location.href="list.jsp";
	  			</script>

	<%
			rs.close();
			stmt.close();
			conn.close();
			
			 } else { 
	%>
				<script language=javascript>
				 self.window.alert("비밀번호를 틀렸습니다.");
					location.href="javascript:history.back()";
				</script>
	<%		
			 }
	 	} catch(SQLException e) {
			out.println( e.toString() );
		} 
	%>
		 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

</body>
</html>