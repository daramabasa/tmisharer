<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*,javax.naming.*" %>
<%
	Connection conn = null;
	String sql="SELECT * FROM member WHERE id=?";
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	Boolean result=false;
	
	try{
		Context init=new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			result=false;
		} else {
			result=true;
		}
	} catch(Exception e){
		e.printStackTrace();
	} finally{
		try{
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
useID();
function useID(){
	if(<%=result%>)
		{
		opener.document.querySelector("#chk").checked=true;
		opener.document.querySelector("#duplicationChk").disabled=true;
		opener.document.querySelector("#chkResult").innerHTML= "사용 가능한 아이디입니다.";
		
		}else{
			opener.document.querySelector("#chk").checked=true;
			opener.document.querySelector("#duplicationChk").disabled=false;
			opener.document.querySelector("#chkResult").innerHTML= "이미 사용 중인 아이디입니다.";
		}
	self.close();
}

</script>
</body>
</html>