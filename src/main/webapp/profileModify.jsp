<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String session_id = (String) session.getAttribute("id");
	String request_id = (String) request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>프로필 수정 화면</title>
	<link rel="stylesheet" href="css/index_css.css?ver=1">
	
	<style>
		.container{
	         width: 850px; height: 900px;
	
	         margin: 0 auto; margin-top: 1vh;
	         padding: 35px; padding-top: 150px;
	         box-sizing: border-box;
	
	         text-align: center;
	
	         border-radius: 80px;
	         box-shadow: 0px 50px 10px rgba(0,0,0,0.3);
	
	         background-color: white;
	     }
	     
	     #profile_short {
	     	width: 400px; height: 40px;
	     	padding: 0 20px;
            margin: 0 auto; margin-top: 5px;

			box-sizing: border-box;
            line-height: 40px;
	     	border: none;
            
            background-color: #ddd;
            cursor: pointer;
	     }
	     
	     input[type="submit"] {
	     	width: 450px; height: 70px;
	        padding: 15px;
	     	margin-top: 50px;
	        box-sizing: border-box;
	     	
	        border-radius: 10px;
	        border: none;
	        
	        box-shadow: 0 5px 0px rgba(0, 0, 0, 0.3);
	        background-color: #D8D8D8;
	        cursor: pointer;
	     }
	     	input[type="submit"]:active {
	        	box-shadow: none;
	     	}
	     
	</style>
</head>
<body>
<div class="container">
	<form class="profilesection" action="index.jsp" method="POST">
        <div class="top">
        	<input type="file" id="profile_img" name="profile_img" hidden>
            <label for="profile_img"><div class="profileimg"></div></label>
        </div>
        <div class="profileid">
            ID <%=session_id %>
        </div>
        <div class="short">
	        <input type="text" id="profile_short" name="profile_short" title="~~자까지 입력 가능합니다."
	        			value="#한줄소개#ExampleShortDescriptionOfMine">
        </div>
        <br>
    	<input type="submit" value="수정">
    </form>
</div>
</body>
<script>
	let profile_img = document.getElementById("profile_img").value;
	
	document.getElementsByClassName("profileimg")[0].style.background = url(profile_img);
</script>
</html>