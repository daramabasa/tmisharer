<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 페이지  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>

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
      width: 500px; height: 100px;
      --background-color: #ddd;
      margin: 0 auto;
      margin-bottom: 50px;
    }
      header > h1 { line-height: 100px; }

    section {
      padding: 50px 0;
      margin: 20px 0 50px 0;
    }
      section input {
        width: 450px; height: 70px;
        margin: 5px 0;

        border-radius: 10px;
        border: none;

        background-color: #D8D8D8;
      }

      input[type="submit"] {
        margin-top: 20px;
        box-shadow: 0 5px 0px rgba(0, 0, 0, 0.3);
      }

      input[type="submit"]:active {
        box-shadow: none;
      }

    .iconsection {
      margin-top: 20px;
      text-align: center;
    }
      .icon {
        width: 90px; height: 90px;
        display: inline-block;
        background-color: #ddd;
      }
  footer h6 {
        margin-top: 100px;
        text-align: center;
        color: #ccc;
    }
  </style>
</head>
<body>

	<div class="container">
	    <header>
	      <img src="images/title.png" alt="title">
	    </header>
	    
	    <section>
	      <form action="loginProcess.jsp" method="POST">
	        <input type="text" name="id" id="id" placeholder="아이디" required="required">
	        <input type="password" name="passwd" id="passwd" placeholder="비밀번호" required="required">
	        <input type="submit" value="로그인">
	      </form>
	    </section>
	
	    <a href="joinPage.jsp">회원가입</a>
	    <div class="iconsection">
	      <div class="icon" id="naverIdLogin"></div>
	      <div class="icon">
	      	<ul>
				<li onclick="kakaoLogin();">
			      <a href="javascript:void(0)">
			         <img src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222" />
			      </a>
				</li>
				<li onclick="kakaoLogout();">
			      <a href="javascript:void(0)">
			          <span>카카오 로그아웃</span>
			      </a>
				</li>
			</ul>
	      </div>
	      <div class="icon"></div>
	    </div>
  </div>
  <footer><h6>Copyright. 2022. 서혜원, 임소연, 이세원. All rights reserved.</h6></footer>
  
 <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
 <script type="text/javascript">
	 
	 const naverLogin = new naver.LoginWithNaverId({
	   clientId: "6FiWl1aonR5NDzcaLGXy",
	   callbackUrl: "http://localhost:8088/TMIpro/login.jsp",
	   loginButton: {color: "green", type: 3, height: 40}
	  });
	 
	 naverLogin.init();
	 naverLogin.getLoginStatus(function (status) {
	   if (status) {
	       const nickName=naverLogin.user.getNickName();
	       const email=naverLogin.user.getEmail();
	
	       if((nickName===null||nickName===undefined )&&(email===null||email===undefined)){
	         alert("이메일과 별명이 필요합니다. 정보제공을 동의해주세요.");
	         naverLogin.reprompt();
	         return ;  
	      }else{
	       setLoginStatus();
	      }
	}
	 });
	 console.log(naverLogin);
	
	 function setLoginStatus(){
	 
	   const message_area=document.getElementById('message');
	   message_area.innerHTML=`
	   <h3> Login 성공 </h3>
	   <div>user Nickname : ${naverLogin.user.nickname}</div>
	   <div>user Email : ${naverLogin.user.email}</div>
	   `;
	  
	   const button_area=document.getElementById('button_area');
	   button_area.innerHTML="<button id='btn_logout'>로그아웃</button>";
	
	   const logout=document.getElementById('btn_logout');
	  		logout.addEventListener('click',(e)=>{
		    	naverLogin.logout();
				location.replace("http://localhost:8088/TMIpro/loginPage.jsp");
	   })
	 }
</script>



<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	Kakao.init('491b961c8499b0439b80f9800bbc9b1d'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function kakaoLogin() {
	    Kakao.Auth.login({
	      success: function (response) {
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function (response) {
	            
	              alert('로그인 성공');
	          
	        	  console.log(response)
	        	  response.sendRedirect("index.jsp");
	  				return;
	          },
	          fail: function (error) {
	            console.log(error)
	          },
	        })
	      },
	      fail: function (error) {
	        console.log(error)
	      },
	    })
	  }
	//카카오로그아웃  
	function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        	alert('로그아웃 성공');
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
	  }  
</script>
</body>
</html>