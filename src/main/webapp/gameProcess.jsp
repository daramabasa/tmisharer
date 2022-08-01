<%@page import="java.text.SimpleDateFormat, java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Date nowTime = new Date();//date객체를 이용해 현재 시간 nowTime으로 받아옴
	SimpleDateFormat st = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); //SimpleDateFormat 클래스로 date는 "yyyy/MM/dd" time은 "hh:mm:ss"로 받아옴
	String gamedate = st.format(nowTime); //regidate는 현재 시간 
	
	String session_id = (String) session.getAttribute("id");
	int game_no = Integer.parseInt(request.getParameter("game_no"));
	int result_no = Integer.parseInt(request.getParameter("result0" + game_no));
	if(session_id != null) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
			
			pstmt = conn.prepareStatement("UPDATE game SET result0" + game_no + "=?, gamedate=? WHERE id=?");
			pstmt.setInt(1, result_no);
			pstmt.setString(2, gamedate);
			pstmt.setString(3, session_id);
			
			System.out.println("업데이트: " + pstmt.executeUpdate());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	response.sendRedirect("index.jsp");
	return;

%>