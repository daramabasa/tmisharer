<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% 

	String session_id = (String) session.getAttribute("id");
	String request_id = (String) request.getParameter("id");
	boolean overwrite = false;
	if(session.getAttribute("overwrite") != null) {
		overwrite = (boolean) session.getAttribute("overwrite");
		System.out.println("overwrite: " + overwrite);
	}
	
	System.out.println("request id: " + request_id);
	System.out.println("session id: " + session_id);
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 게임 결과 보여주는 sql
	String sql1 = "SELECT * FROM member, game WHERE member.id = game.id AND member.id=?";
	
	// 해당 선택 사람 수 보여주는 sql
	String sql2 = "SELECT COUNT(*) FROM game WHERE";
	
	// 친구 추측 보여주는 sql
	String sql3 = "SELECT * FROM (SELECT * FROM quiz WHERE id=? ORDER BY guessdate DESC) WHERE ROWNUM <= 5";
	
	boolean login = session_id != null;
	boolean shareLink = request_id != null;
	int countList[] = new int[5];
	String selectList[] = new String[5];
	String descList[] = new String[5];
	String profile_img = null;
	String profile_short = null;
	
	Cookie cookies[] = request.getCookies();
	int cookieList[] = new int[5];
	
	if(cookies != null) {
		for(int i = 0; i < cookies.length; i++) {
			Cookie c = cookies[i];
			switch (c.getName()) {
				case "result01":
					cookieList[0] = Integer.parseInt(c.getValue());
					break;
				case "result02":
					cookieList[1] = Integer.parseInt(c.getValue());
					break;
				case "result03":
					cookieList[2] = Integer.parseInt(c.getValue());
					break;
				case "result04":
					cookieList[3] = Integer.parseInt(c.getValue());
					break;
				case "result05":
					cookieList[4] = Integer.parseInt(c.getValue());
					break;
					
				default:
					continue;
			}
		}
	}
	
	String dbList[] = new String[5];
	
			
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement(sql1);
		
		if(shareLink) {
			pstmt.setString(1, request_id);
		}else if(login) {
			pstmt.setString(1, session_id);
		}
		
		if(shareLink || login) {
			rs = pstmt.executeQuery();
	
			if(rs.next()){
				
				if(rs.getString("profile") != null) profile_img = rs.getString("profile");
				if(rs.getString("intro") != null) profile_short = rs.getString("intro"); 
				
				ResultSet rs2 = null;
				for(int i = 1; i <= 5; i++) {
					pstmt = conn.prepareStatement("SELECT img_width, result_desc FROM src WHERE game_no=? AND result_no=?");
					pstmt.setInt(1, i);
					pstmt.setInt(2, rs.getInt("result0"+i));
					
					rs2 = pstmt.executeQuery();
					if(rs2.next()) {
						selectList[i-1] = rs2.getString(1);
						descList[i-1] = rs2.getString(2);
					}
					
					pstmt = conn.prepareStatement(sql2 + " result0" + i + "=?");
					pstmt.setInt(1, rs.getInt("result0"+i));
					
					rs2 = pstmt.executeQuery();
					if(rs2.next()) {
						countList[i-1] = rs2.getInt(1);
					}
				}
				
				if(rs2 != null) rs2.close();
				
			}
			
		} else {
			
			for(int i = 0; i < 5; i++) {
				pstmt = conn.prepareStatement("SELECT img_width, result_desc FROM src WHERE game_no=? AND result_no=?");
				pstmt.setInt(1, i+1);
				pstmt.setInt(2, cookieList[i]);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					selectList[i] = rs.getString(1);
					descList[i] = rs.getString(2);

					ResultSet rs2 = null;
					
					pstmt = conn.prepareStatement(sql2 + " result0" + (i+1) + "=?");
					pstmt.setInt(1, cookieList[i]);
					
					rs2 = pstmt.executeQuery();
					if(rs2.next()) {
						countList[i] = rs2.getInt(1) + 1;
					}
				}
				
			}
			
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="밸런스 게임을 진행하고 나의 TMI를 친구에게 공유해보세요.">
    <meta property="og:title" content="TMI공유기">
    <!-- <meta name="og:url" content="http://192.168.0.21:8080/TeamProject03/index.jsp"> -->
    <meta property="og:image" content="">
    
	<title>프로필 화면</title>
	<link rel="stylesheet" href="css/index_css.css?ver=1">
	<style>
	@font-face {
    font-family: 'SEBANG Gothic Bold';
    src: url('fonts/세방고딕/SEBANG-Gothic-Bold.woff') format('woff');
}
	@font-face {
    font-family: 'SEBANG Gothic Regular';
    src: url('fonts/세방고딕/SEBANG-Gothic-Regular.woff') format('woff');
}
*{
	font-family: 'SEBANG Gothic Bold';
}
.profileid{
background-color:#FFFFFF;
}
.short{
font-family: 'SEBANG Gothic Regular';
background-color:#FFFFFF;
color:#D8D8D8;
}
.game h4{
font-family: 'SEBANG Gothic Regular';
color:#FFFFFF;
}
#login{
color:#FFFFFF;
}
#logout{
color:#FFFFFF;
}
.share{
color:#FFFFFF;
}
	<% if(session_id == null && request_id == null) { %>
		.container{
            width: 850px; height: 1450px;

            margin: 0 auto; margin-top: 1vh;
            padding: 35px;
            box-sizing: border-box;

            text-align: center;

            border-radius: 80px;
            box-shadow: 0px 50px 10px rgba(0,0,0,0.3);

            background-color: white;
        }
	<% } else { %>
		.container{
	           width: 850px; height: 1650px;
	
	           margin: 0 auto; margin-top: 1vh;
	           padding: 35px;
	           box-sizing: border-box;
	
	           text-align: center;
	
	           border-radius: 80px;
	           box-shadow: 0px 50px 10px rgba(0,0,0,0.3);
	
	           background-color: white;
	       }
    <% } %>
    
    
	    .profile_img {
		   background-color: #D8D8D8; 
		   background-size: cover;
	       background-repeat: no-repeat;
	       background-position: center;
	       <%if(profile_img != null) { %>
	           background-image: url("<%=profile_img %>");
	       <% } %>
	    }
    
	</style>
</head>
<body>
<div class="container">
    <div class="profilesection">
        <div class="top">
            <div class="profileimg" onclick="modify();"></div>
            <%if(session_id == null) { %>
            	<button class="btn" id="login" onclick="location.href='loginPage.jsp'">로그인</button>
            <%} else {  %>
            	<button class="btn" id="logout" onclick="location.href='logout.jsp'">로그아웃</button>
            <%} %>
        </div>
        <div class="profileid">
            ID <%=(request_id != null) ? request_id : (session_id != null) ? session_id : "GUEST" %>
        </div>
        <div class="short" onclick="modify();">
            <%=(profile_short != null) ? "#" + profile_short : "#한줄소개#ExampleShortDescriptionOfMine" %>
        </div>
    </div>
    <div class="resultsection">
        <div class="game" id="likeGame">
            <h2>#Example</h2>
            <h4>#가장 좋아하는 사람 유형</h4>
        </div>
        <div class="game" id="placeGame">
            <h2>#Example</h2>
            <h4>#가장 좋아하는 장소</h4>
        </div>
        <div class="game" id="animalGame">
            <h2>#Example</h2>
            <h4>#가장 좋아하는 동물</h4>
        </div>
        <div class="game" id="activeGame">
            <h2>#Example</h2>
            <h4>#가장 좋아하는 활동</h4>
        </div>
        <div class="game" id="dislikeGame">
            <h2>#Example</h2>
            <h4>#가장 싫어하는 사람 유형</h4>
        </div>
    </div>
    <div class="countsection">
    <%
    	for(int i = 0; i < 5; i++) {
    		if(descList[i] == null) {
    			%>
    				<p class="countresult">해당 밸런스 게임이 아직 진행되지 않았습니다.</p> 
    			<%
    			continue;
    		}
    		if(i == 4) {
    			%>
    				<p class="countresult"><span class="count_highlight"><%=countList[i] %></span>명의 사람들이 <span class="count_highlight">#<%=descList[i] %></span>을(를) 가장 싫어한다고 답했습니다.</p> 
    			<%
    		} else {
    		
    		%>
    			<p class="countresult"><span class="count_highlight"><%=countList[i] %></span>명의 사람들이 <span class="count_highlight">#<%=descList[i] %></span>을(를) 가장 좋아한다고 답했습니다.</p>
    		<%
    		}
    	}
    %>
               
    </div>
    
    <div class="friendsection">
        <div id="friendtitle"><h1>친구들의 예상</h1></div>
        <%
        	try {
        		Context init = new InitialContext();
        		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
        		conn = ds.getConnection();
        		
        		pstmt = conn.prepareStatement(sql3);
        		if(shareLink) {
        			pstmt.setString(1, request_id);
        		}else if(login) {
        			pstmt.setString(1, session_id);
        		}

        		if(shareLink || login) {
        			
	        		ResultSet rs2 = pstmt.executeQuery();
	        		
	        		if(rs2 == null) {
	        			%>
	        				<div class="friend_alert">아직 예상해준 친구가 없습니다. 링크를 공유해서 친구에게 보내보세요.</div>
	        			<%
	        		} else {
		        		while(rs2.next()){
		        			
		        			for(int i = 1; i <= 5; i++) {
		        				pstmt = conn.prepareStatement("SELECT result_desc FROM src WHERE game_no=? AND result_no=?");
		        				pstmt.setInt(1, i);
		        				pstmt.setInt(2, rs2.getInt("guess0" + i));
		        				
		        				rs = pstmt.executeQuery();
		        				
		        				if(rs.next()) {
		        					dbList[i-1] = rs.getString(1);
		        				}
		        				
		        			}
        			
	        %>
		        <div class="friend">
		            <img src="" alt="" width="35px" height="35px">
		            <span class="friend_name"><%=rs2.getString("name") %>:</span> 
		            <div class="guess">#<%=dbList[0] %></div>
		            <div class="guess">#<%=dbList[1] %></div>
		            <div class="guess">#<%=dbList[2] %></div>
		            <div class="guess">#<%=dbList[3] %></div>
		            <div class="guess">#<%=dbList[4] %></div>
		        </div>
	        <%
	        			}
	        		}
	        		
	        		if(rs2 != null) rs2.close();
        		} else {
        			%>
        				<div class="info">
        					TMI 공유기 회원만 이용가능한 부분입니다.<br>
        					지금 회원가입해서 친구에게 공유해보세요.
        				</div>
        			<%
        		}
        		
        	} catch (Exception e) {
        		e.printStackTrace();
        	} finally {
        		try {
	        		if(rs != null) rs.close();
	        		if(pstmt != null) pstmt.close();
	        		if(conn != null) conn.close();
        		} catch (Exception e) {
        			e.printStackTrace();
        		}
        	}
        %>
    </div>
    
    <% if(request_id == null && session_id == null) { %>
    	<button class="share" id="share">페이지 공유하기</button><br>
    <% } %>
    
    <% if(session_id != null || (request_id != null && session_id == request_id)) { %>
    	<button class="share" id="share">나의 프로필 공유하기</button><br>
    	<button class="share" id="quiz">문제지 제작하기</button>
    <% } %>
    <% if(request_id != null && ((session_id != null) ? (!session_id.equals(request_id)) : true)) { %>
    	<button class="share" id="goto" onclick="location.href='index.jsp'">나도 해보러 가기</button>
    <% } %>
    
    <div class="share-dialog">
      <header>
   		<h3 class="dialog-title">다른 사람들과 공유해보세요</h3>	  
	    <button class="close-button"><svg><use href="#close"></use></svg></button>
	  </header>
	  
	  <div class="targets">
	    <a class="button">
	      <svg>
	        <use href="#facebook"></use>
	      </svg>
	      <span>Facebook</span>
	    </a>	    
	    <a class="button">
	      <svg>
	        <use href="#twitter"></use>
	      </svg>
	      <span>Twitter</span>
	    </a>	    
	    <a class="button">
	      <svg>
	        <use href="#linkedin"></use>
	      </svg>
	      <span>LinkedIn</span>
	    </a>	    
	    <a class="button">
	      <svg>
	        <use href="#email"></use>
	      </svg>
	      <span>Email</span>
	    </a>
	  </div>
	  
	  <div class="link">
	    <div class="pen-url"></div>
	    <button type="button" id="clipboard">Copy Link</button>
	  </div>
	</div>	
		
	
	<svg class="hidden">
	  <defs>
	    <symbol id="share-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-share">
	    <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8"></path>
	    <polyline points="16 6 12 2 8 6"></polyline>
	    <line x1="12" y1="2" x2="12" y2="15"></line></symbol>
	        
	    <symbol id="facebook" viewBox="0 0 24 24" fill="#3b5998" stroke="#3b5998" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-facebook">
	    <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></symbol>  
	      
	    <symbol id="twitter" viewBox="0 0 24 24" fill="#1da1f2" stroke="#1da1f2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-twitter">
	    <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></symbol>    
	    
	    <symbol id="email" viewBox="0 0 24 24" fill="#777" stroke="#fafafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-mail">
	    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
	    <polyline points="22,6 12,13 2,6"></polyline></symbol> 
	       
	    <symbol id="linkedin" viewBox="0 0 24 24" fill="#0077B5" stroke="#0077B5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-linkedin">
	    <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path>
	    <rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></symbol>
	        
	    <symbol id="close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x-square">
	    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
	    <line x1="9" y1="9" x2="15" y2="15"></line>
	    <line x1="15" y1="9" x2="9" y2="15"></line></symbol>
	  </defs>
	</svg> 
</div>

<footer><h6>Copyright. 2022. 서혜원, 임소연, 이세원. All rights reserved.</h6></footer>
</body>
<script>
    let likeGame = document.querySelector("#likeGame");
    let placeGame = document.querySelector("#placeGame");
    let animalGame = document.querySelector("#animalGame");
    let activeGame = document.querySelector("#activeGame");
    let dislikeGame = document.querySelector("#dislikeGame");
    
    likeGame.addEventListener('click', function(){
        if((<%=shareLink %> == false) || (<%=session_id != null ? (session_id.equals(request_id)) : false %>)) location.href="gamePage.jsp?game_no=1";
    });
    
    placeGame.addEventListener('click', function(){
    	if(<%=shareLink %> == false || (<%=session_id != null ? (session_id.equals(request_id)) : false %>)) location.href="gamePage.jsp?game_no=2";
    });
    
    animalGame.addEventListener('click', function(){
    	if(<%=shareLink %> == false || (<%=session_id != null ? (session_id.equals(request_id)) : false %>)) location.href="gamePage.jsp?game_no=3";
    });
    
    activeGame.addEventListener('click', function(){
    	if(<%=shareLink %> == false || (<%=session_id != null ? (session_id.equals(request_id)) : false %>)) location.href="gamePage.jsp?game_no=4";
    });
    
    dislikeGame.addEventListener('click', function(){
    	if(<%=shareLink %> == false || (<%=session_id != null ? (session_id.equals(request_id)) : false %>)) location.href="gamePage.jsp?game_no=5";
    });
    
    function inithref(url) {
        let url_array = url.split("/");
        let inittext = '';

        for(let i = 0; i < url_array.length-1; i++) {
            inittext += url_array[i] + "/";
        }

        return inittext;
    }
    
    // 웹 쉐어
    const shareButton = document.querySelector('#share');
    const quizButton = document.querySelector('#quiz');
    
    const shareDialog = document.querySelector('.share-dialog');
    const closeButton = document.querySelector('.close-button');
    
    const clipboard = document.querySelector("#clipboard");
    
    shareButton.addEventListener('click', event => {
    	let link = inithref(window.document.location.href);
        if(<%=((request_id == null && session_id == null) ? true : false) %>) {
       	 link += "index.jsp";
        } else {
       	 link += "index.jsp?id=" + "<%=session_id%>";
        }
    	  if (navigator.share) { 
    	   navigator.share({
    	      title: '다른 사람들과 공유해보세요',
    	      url: link
    	    }).then(() => {
    	      console.log('성공');
    	    })
    	    .catch(console.error);
    	    } else {
    	        shareDialog.classList.add('is-open');
    	        clipboard.addEventListener("click", clip("index.jsp"));
    	    }
    	});
    
    closeButton.addEventListener('click', event => {
  	  shareDialog.classList.remove('is-open');
  	});
    
/*    	document.addEventListener("mouseup", function(e) {
   		if(shareDialog.style.display != ("none")){
   			if(e.target.className != "share-dialog is-open") {
   				console.log(e.target);
				shareDialog.classList.remove('is-open');
   			}
   		}
    }); */
    
    if(quizButton != null) {
    	quizButton.addEventListener('click', event => {
   		  let link = inithref(window.document.location.href);
          link += "sharequiz.jsp?id=" + "<%=session_id %>";
       	  if (navigator.share) { 
       	   navigator.share({
       	      title: '다른 사람들과 공유해보세요',
       	      url: link
       	    }).then(() => {
       	      console.log('성공');
       	    })
       	    .catch(console.error);
       	    } else {
       	        shareDialog.classList.add('is-open');
       	        clipboard.addEventListener("click", clip("sharequiz.jsp"));
       	    }
       	});
    }
    	

   	    	
   	 //URL 복사
     function clip(nextPage){
     	let link = inithref(window.document.location.href);
         if(<%=((request_id == null && session_id == null) ? true : false) %>) {
        	 link += nextPage;
         } else {
        	 link += nextPage + "?id=" + "<%=session_id%>";
         }
     	var textarea = document.createElement("textarea");
     	document.body.appendChild(textarea);
     	url = window.document.location.href;
     	textarea.value = link;
     	textarea.select();
     	document.execCommand("copy");
     	document.body.removeChild(textarea);
     }

    if("<%=selectList[0] %>" != "null") {
   	    likeGame.style.backgroundImage = "url('" + "images/좋아하는 사람 유형/<%=selectList[0] %>" +  "')";
        likeGame.children[0].innerText = "<%=descList[0] %>" == "null" ? "#Example" : "#<%=descList[0] %>";
    }
    if("<%=selectList[1] %>" != "null") {
        placeGame.style.backgroundImage = "url('" + "images/장소/<%=selectList[1] %>" +  "')";
        placeGame.children[0].innerText = "<%=descList[1] %>" == "null" ? "#Example" : "#<%=descList[1] %>";
    }
    if("<%=selectList[2] %>" != "null") {
        animalGame.style.backgroundImage = "url('" + "images/동물/<%=selectList[2] %>" +  "')";
        animalGame.children[0].innerText = "<%=descList[2] %>" == "null" ? "#Example" : "#<%=descList[2] %>";
    }
    if("<%=selectList[3] %>" != "null") {
        activeGame.style.backgroundImage = "url('" + "images/활동/<%=selectList[3] %>" +  "')";
        activeGame.children[0].innerText = "<%=descList[3] %>" == "null" ? "#Example" : "#<%=descList[3] %>";
    }
    if("<%=selectList[4] %>" != "null") {
        dislikeGame.style.backgroundImage = "url('" + "images/싫어하는 사람 유형/<%=selectList[4] %>" +  "')";
        dislikeGame.children[0].innerText = "<%=descList[4] %>" == "null" ? "#Example" : "#<%=descList[4] %>";
    }
    
   document.addEventListener("DOMContentLoaded", function(event) { 
		if(<%=login %> && <%=!shareLink %>) {
			if(<%=cookies != null %> && <%=!overwrite %>) {
				if(confirm("로그인 전에 진행한 기록이 있습니다. 해당 기록으로 덮어쓰시겠습니까?")) {
					location.href="dataOverwrite.jsp";
				} else {
					return;
				}
			}
		}
	});
   
   
   function modify() {
	   if(<%=login %>) {
		   location.href="profileModify.jsp";
	   }
   }
</script>
</html>