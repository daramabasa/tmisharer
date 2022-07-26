<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
* { padding: 0; maring: 0; }
	form { width: 380px; padding: 30px; margin: 0 auto; }
	fieldset {
		width: 340px;
		padding: 18px;
	}
	
		label {
			width: 120px;
			clear: both; float: left;
		}
		
		fieldset input {
			width: 150px;
			float: left;
			margin-bottom : 5px;
		}
		
		fieldset input[type=button] {
			width: 60px;
			margin-left: 5px;
		}
		
		h6 {
			width: 100%;
			clear: both;
			text-align: right;
			margin-bottom: 10px;
			
			color: red;
		}
		
	div > input, button {
		width: 100px;
		margin-top: 10px;
	}
	
	div.divArea {
		width: 360px;
		margin: 0 auto;
		
		text-align: center;
	}
		div#atagArea{
			font-size: small;
			font-weight: bold;
		}
</style>
</head>
<body>
	<form action="regInsert.jsp" method="POST" onsubmit="return chkForm();">
		<fieldset>
		<legend>회원가입</legend>
			<label for="id">아이디 </label>
			<input type="text" name="id" id="id" required="required" onkeydown="checkMessage()">
			<input type="hidden" name="chk" id="chk">
			<input type="button" value="중복확인" onclick="chkID()" id="duplicationChk">
			<h6 id="chkResult">아이디 중복 확인을 진행해주세요.</h6>
			<label for="passwd">비밀번호 </label>
			<input type="password" name="passwd" id="passwd" required="required">
			<br>
			<label for="passwdConfirm">비밀번호 확인 </label>
			<input type="password" name="passwdConfirm" id="passwdConfirm" required="required">
			<h6 id="chkConfirm"></h6>
			<br>
			<label for = "name">닉네임 </label>
			<input type="text" name="name" id = "name" required="required"/>

		</fieldset>
		<div class="divArea">
			<input type="reset" value="초기화">
			<button onclick="return chkForm();">회원가입</button>
		</div>
	</form>
	<div class="divArea" id="atagArea">아이디가 있으면 <a href="login.jsp">로그인</a></div>
</body>
<script src="joinscript.js"></script>
</html>