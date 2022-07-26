<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 페이지  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>

<style>
* { padding: 0; margin: 0; }
body { text-align: center; }
form { width: 360px; padding: 30px; margin: 0 auto; }
	fieldset {
		width: 340px; height: 80px;
		padding: 8px;
	}
		label {
			width: 100px;
			clear: both; float: left;
		}
		
		fieldset input {
			width: 150px;
			float: left;
			margin-bottom : 5px;
		}
	
	div > input {
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
			ul {
	list-style : none;
	}
</style>
</head>
<body>
	<form action="loginProcess.jsp" method="POST">
		<fieldset>
			<legend>로그인</legend>
			<label for="id">아이디 </label>
			<input type="text" name="id" id="id" required="required">
			<br>
			<label for="passwd">비밀번호 </label>
			<input type="password" name="passwd" id="passwd" required="required">
			<br>
		</fieldset>
		<div class="divArea">
			<input type="reset" value="다시입력">
			<input type="submit" value="로그인">
		</div>
	</form>
	<div class="divArea" id="atagArea">아이디가 없으면 <a href="regStep1.jsp">회원가입</a></div><br>
	 <div class="container">
    <div class="login-area">
      <div id="button_area">
        <div id="naverIdLogin"></div>
      </div>
    </div>
  </div>
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
  <script type="text/javascript">
  
  const naverLogin = new naver.LoginWithNaverId(
   {
    clientId: "6FiWl1aonR5NDzcaLGXy",
    callbackUrl: "http://localhost:8088/TMIpro/login.jsp",
    loginButton: {color: "green", type: 3, height: 40}
    }
   );
  
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
	location.replace("http://localhost:8088/TMIpro/login.jsp");
    })
  }
</script>

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
        	  response.sendRedirect("index.html");
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