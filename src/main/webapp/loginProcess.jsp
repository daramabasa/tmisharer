<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<%
	Connection conn = null;
	String sql = "SELECT * FROM member WHERE id=? and passwd=?";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("passwd"));
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			session.setAttribute("id", request.getParameter("id"));
			response.sendRedirect("index.jsp");
			return;
		}
		else {
			//out.print("<script>alert('아이디 또는 비밀번호가 틀립니다.'); location.href='loginPage.jsp';</script>");
			response.sendRedirect("loginPage.jsp");
			return;
		}
		
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("loginPage.jsp");
		return;
		
	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("loginPage.jsp");
			return;
		}
	}

%>