<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String session_id = (String) session.getAttribute("id");

	Date nowTime = new Date();//date객체를 이용해 현재 시간 nowTime으로 받아옴
	SimpleDateFormat st = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); //SimpleDateFormat 클래스로 date는 "yyyy/MM/dd" time은 "hh:mm:ss"로 받아옴
	String gamedate = st.format(nowTime); //regidate는 현재 시간 

	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "UPDATE game SET ";

	Cookie cookies[] = request.getCookies();
	int cookieList[] = new int[5];
	
	if(cookies != null) {
		for(int i = 0; i < cookies.length; i++) {
			Cookie c = cookies[i];
			switch (c.getName()) {
				case "result01":
					cookieList[0] = Integer.parseInt(c.getValue());
					sql += "result01=" + cookieList[0] + ",";
					break;
				case "result02":
					cookieList[1] = Integer.parseInt(c.getValue());
					sql += "result02=" + cookieList[1] + ",";
					break;
				case "result03":
					cookieList[2] = Integer.parseInt(c.getValue());
					sql += "result03=" + cookieList[2] + ",";
					break;
				case "result04":
					cookieList[3] = Integer.parseInt(c.getValue());
					sql += "result04=" + cookieList[3] + ",";
					break;
				case "result05":
					cookieList[4] = Integer.parseInt(c.getValue());
					sql += "result05=" + cookieList[4] + "";
					break;
					
				default:
					continue;
			}
		}
	}
	
	sql += "gamedate=? WHERE id=?"; 
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, gamedate);
		pstmt.setString(2, session_id);
		
		if(pstmt.executeUpdate() > 0) {
			System.out.println("처리 성공");
			response.sendRedirect("index.jsp");
			return;
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
</head>
<body>
	<form action="index.jsp" method="POST">
		<input type="hidden" value="true" name="overwrite" id="overwrite">
	</form>
</body>
</html>