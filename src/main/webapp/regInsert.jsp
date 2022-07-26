<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<%@ page import="java.util.Date" %> 
<%@ page import="java.text.SimpleDateFormat" %>

<%
Date nowTime = new Date();//date객체를 이용해 현재 시간 nowTime으로 받아옴
SimpleDateFormat st = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); //SimpleDateFormat 클래스로 date는 "yyyy/MM/dd" time은 "hh:mm:ss"로 받아옴
String regidate = st.format(nowTime); //regidate는 현재 시간 

	String id = request.getParameter("id");
	String password = request.getParameter("passwd");
	String name = request.getParameter("name");

	
	Connection conn = null;
	String sql = "INSERT INTO member(id,passwd,name,profile,intro,regidate) VALUES(?,?,?,?,?,?)";
	PreparedStatement pstmt = null;
	
	

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/JSP_java");
		conn = ds.getConnection();

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("passwd"));
		pstmt.setString(3, request.getParameter("name"));
		pstmt.setString(4, null);
		pstmt.setString(5, null);
		pstmt.setString(6, regidate);
		
		int result= pstmt.executeUpdate();	

		
		if(result != 0) {
			response.sendRedirect("login.jsp");
			return;
			
		}
	} catch(Exception e) {
		e.printStackTrace();
		response.sendRedirect("regStep1.jsp");
	} finally {
		try {
			pstmt.close();
			conn.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
%>