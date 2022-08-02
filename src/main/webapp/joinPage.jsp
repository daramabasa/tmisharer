<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
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
      margin-bottom: 10px;
    }
      header > h1 { line-height: 100px; }

    section {
      width: 460px; height: 525px;
      margin: 0 auto;
      padding: 15px;
    }
      section input {
          width: 450px; height: 70px;
          margin-bottom: 15px;
          border-radius: 10px;
          border: none;
          background-color: #D8D8D8;

          float: left;
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
    h6 {
        text-align: center;
        color: #ccc;
    }
    :root {
    --error-color: #dc3545;
    --success-color: #28a745;
    --warning-color: #ffc107;
}

.form-field label {
    display: block;
    color: #777;
}

.form-field input {
    border: solid 2px #f0f0f0;
    display: block;
}

.form-field input:focus {
    outline: none;
}

.form-field.error input {
    border-color: var(--error-color);
}

.form-field.success input {
    border-color: var(--success-color);
}


.form-field small {
    color: var(--error-color);
    margin-bottom: 5px;
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
	        <input type="text" name="id" id="id" placeholder="아이디" required onkeydown="checkMessage()">
	        <input type="hidden" name="chk" id="chk">
	        <small></small>
	            </div>
	        
	        <input type="button" value="중복 확인" onclick="chkID();" id="duplicationChk">
	        <h6 id="chkResult">아이디 중복 확인을 진행해주세요.</h6>
	        
	        <div class="form-field">
	        <input type="password" name="passwd" id="passwd" placeholder="비밀번호" required>
	        <small></small>
	            </div>
	            
	         <div class="form-field">    
	        <input type="password" name="passwdConfirm" id="passwdConfirm" placeholder="비밀번호 확인" required>
	        <h6 id="chkConfirm"></h6>
	        <small></small>
	            </div>
	        
	        <input type="text" name="name" id="name" placeholder="닉네임" pattern="^[a-zA-Z가-힣]*$" required title="영어 21자, 한글 7자만 가능" >
	        
	        <div class="form-field">
	        	<input type="submit" value="회원가입" class="btn">
	        </div>
      </form>
    </section>
  </div>

  <footer><h6>Copyright. 2022. 서혜원, 임소연, 이세원. All rights reserved.</h6></footer>
  <script src="joinscript.js?ver=3"></script>
</body>

</html>