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
	String sql2 = "INSERT INTO game(id, gamedate) VALUES(?,?)";
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	
	System.out.println("joinProcess.jsp");

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("passwd"));
		pstmt.setString(3, request.getParameter("name"));
		pstmt.setString(4, null);
		pstmt.setString(5, null);
		pstmt.setString(6, regidate);
		
		pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, request.getParameter("id"));
		pstmt2.setString(2, regidate);
		
		int result = pstmt.executeUpdate();	
		int result2 = pstmt2.executeUpdate();
		System.out.println("result: " + result + ", result2: " + result2);

		
		if(result != 0 && result2 != 0) {
			response.sendRedirect("loginPage.jsp");
			return;
			
		}
	} catch(Exception e) {
		e.printStackTrace();
		response.sendRedirect("joinPage.jsp");
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