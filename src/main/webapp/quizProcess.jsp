<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Date today = new Date();
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String quizTime = simpleDateFormat.format(today);

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "INSERT INTO quiz VALUES(?,?,?,?,?,?,?,?)";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("name"));
		pstmt.setInt(3, Integer.parseInt(request.getParameter("likeGame")));
		pstmt.setInt(4, Integer.parseInt(request.getParameter("placeGame")));
		pstmt.setInt(5, Integer.parseInt(request.getParameter("animalGame")));
		pstmt.setInt(6, Integer.parseInt(request.getParameter("activeGame")));
		pstmt.setInt(7, Integer.parseInt(request.getParameter("dislikeGame")));
		pstmt.setString(8, quizTime);
	
		if(pstmt.executeUpdate() > 0) {
			response.sendRedirect("index.jsp?id=" + request.getParameter("id"));
			return;
		} 
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>