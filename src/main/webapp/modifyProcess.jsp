<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String session_id = (String) session.getAttribute("id");

	String realFolder = "";
	String saveFolder = "/upload";
	int maxSize = 15*1024*1024;
	String encType = "UTF-8";

	// 상대 경로 지정
/* 	ServletContext context = request.getSession().getServletContext();
	realFolder = context.getRealPath(saveFolder); */
	
	// 절대 경로 지정
	realFolder = "C:/Java/jsp-workspace/TeamProject03/src/main/webapp/upload";
	
/* 	System.out.println("context의 경로: " + context.getContextPath());
	System.out.println("context의 경로: " + context.getRealPath(saveFolder)); */
	
	MultipartRequest multi = null;
	multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

	String img = multi.getFilesystemName("profile_img");
	String shortText = multi.getParameter("profile_short");
	
	Connection conn = null;
	PreparedStatement pstmt = null;;
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement("UPDATE member SET profile=?, intro=? WHERE id=?");
		pstmt.setString(1, img);
		pstmt.setString(2, shortText);
		pstmt.setString(3, session_id);
		
		if(pstmt.executeUpdate() > 0) {
			System.out.println("교체 성공");
			response.sendRedirect("index.jsp");
			return;
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
%>