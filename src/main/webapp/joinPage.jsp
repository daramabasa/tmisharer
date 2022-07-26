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
      margin-bottom: 50px;
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
        margin-top: 100px;
        text-align: center;
        color: #ccc;
    }
  </style>
</head>
<body>

<div class="container">
    <header>
      <img src="images/title.png" alt="title2" width="400px">
    </header>

    <section>
      <form action="joinProcess.jsp" method="POST" onsubmit="return chkForm();">
        <input type="text" name="id" id="id" placeholder="아이디" required onkeydown="checkMessage()">
        <input type="hidden" name="chk" id="chk">
        
        <input type="button" value="중복 확인" onclick="chkID();" id="duplicationChk">
        <h6 id="chkResult">아이디 중복 확인을 진행해주세요.</h6>
        
        <input type="password" name="passwd" id="passwd" placeholder="비밀번호" required>
        <input type="password" name="passwdConfirm" id="passwdConfirm" placeholder="비밀번호 확인" required>
        <h6 id="chkConfirm"></h6>
        
        <input type="text" name="name" id="name" placeholder="닉네임" required>
        <input type="submit" value="회원가입" onclick="return chkForm();">
      </form>
    </section>
  </div>

  <footer><h6>Copyright. 2022. 서혜원, 임소연, 이세원. All rights reserved.</h6></footer>
  
</body>
<script src="joinscript.js"></script>
</html>