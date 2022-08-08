<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
@font-face {
<<<<<<< HEAD
    font-family: 'SEBANG Gothic Regular';
    src: url('font/SEBANG-Gothic.woff') format('woff');
}
*{
	font-family: 'SEBANG Gothic Regular';
	color:white;
=======
    font-family: 'SEBANG Gothic Bold';
    src: url('fonts/세방고딕/SEBANG-Gothic-Bold.woff') format('woff');
}
*{
font-family: 'SEBANG Gothic Bold';
color:white;
>>>>>>> origin/soyeon
}
    body {
      background-color: #eee;
    }

    .container {
      width: 850px; height: 850px;
      margin: 0 auto; margin-top: 1vh;
      padding: 50px;
      text-align: center;
      border-radius: 80px;
      box-shadow: 0px 50px 10px rgba(0, 0, 0, 0.3);
      box-sizing: border-box;
      background-color: white;
    }

    header {
      width: 400px; height: 100px;
      --background-color: #ddd;
      margin: 0 auto;
      margin-bottom: 30px;
    }
      header > h1 { line-height: 100px; }

    section {
      width: 460px; height: 525px;
      margin: 0 auto;
      padding: 15px;
    }
      section input {
          width: 450px; height: 70px;
          margin-bottom: 5px;
          border-radius: 10px;
          border: none;
          background-color: #D8D8D8;

          float: left;
      }
       input::placeholder {
		  color: white;
		} 
        input#id {
          width: 370px;
          margin-right: 10px;
        }

      section input[type="button"] {
        width: 70px; height: 70px;
        display: inline-block;
        border-radius: 10px;
        border: none;
        padding: 15px;
        box-sizing: border-box;
        box-shadow: 0 5px 0px rgba(0, 0, 0, 0.3);
        background-color: #D8D8D8;
        cursor: pointer;
      }

        input[type="submit"] {
          margin-top: 35px;
          box-shadow: 0 5px 0px rgba(0, 0, 0, 0.3);
        }
        input[type="button"] {
          line-height:17px;
        }
    h6 {
    	margin-top: 100px;
        text-align: center;
        color: #ccc;
    }
    :root {
    --error-color: #dc3545;
    --success-color: #28a745;
    --warning-color: #ffc107;
}

.form-field {
	margin-bottom: 15px;
}

.form-field label {
    display: block;
    color: #777;
}

.form-field input {
    display: block;
}

.form-field input:focus {
    outline: none;
}

.form-field.error input:not(#duplicationChk) {
    border: 1px solid var(--error-color);
}

.form-field.success input:not(#duplicationChk) {
    border: 1px solid var(--success-color);
}

.form-field.error small, .form-field.error span {
    color: var(--error-color);
}

.form-field.success small, .form-field.success span {
    color: var(--success-color);
}

.form-field small {
	clear: both;
	display: inline-block;
    margin-bottom: 5px;
    
    font-size: 13px;
}

span {
	clear: both;
	display: block;
    margin: 0 0 5px 0;
    
    color: var(--error-color);
    font-size: 13px;
}

</style>
</head>
<body>

<div class="container">
    <header>
      <img src="images/title.png" alt="title2" width="400px">
    </header>
	
    <section>
      <form id="signup" class="form" action="joinProcess.jsp" method="POST" onsubmit="return chkForm();">
	      <div class="form-field">
	          <input type="text" name="id" id="id" placeholder="   아이디 입력" required onkeydown="checkMessage()">
	          <input type="hidden" name="chk" id="chk">
	        
	          <input type="button" value="중 복&#10;확 인" onclick="chkID();" id="duplicationChk">
	          
	          <span id="chkResult">아이디 중복 확인을 진행해주세요.</span>
	          <small></small>
	      </div>
	        
	      <div class="form-field">
		      <input type="password" name="passwd" id="passwd" placeholder="   비밀번호 입력" required>
		      <small></small>
	      </div>
	            
	      <div class="form-field">    
		       <input type="password" name="passwdConfirm" id="passwdConfirm" placeholder="   비밀번호 확인" required>
	           <small></small>
	      </div>
	       
	      <div class="form-field">
		      <input type="text" name="name" id="name" placeholder="   닉네임 입력" pattern="^[a-zA-Z가-힣]*$" required title="영어 21자, 한글 7자만 가능" >
		      <small></small>
	      </div>
	        
	      <div class="form-field">
	           <input type="submit" value="회원가입" class="btn">
	      </div>
      </form>
    </section>
  </div>

  <footer><h6>Copyright. 2022. 서혜원, 임소연, 이세원. All rights reserved.</h6></footer>
  <script src="js/joinscript.js?ver=19"></script>
</body>

</html>