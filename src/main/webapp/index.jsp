<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% 

	String session_id = (String) session.getAttribute("id");
	String request_id = (String) request.getParameter("id");
	

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 게임 결과 보여주는 sql
	String sql1 = "SELECT * FROM member, game WHERE member.id = game.id AND member.id=?";
	
	// 해당 선택 사람 수 보여주는 sql
	String sql2 = "SELECT COUNT(*) FROM game WHERE";
	
	// 친구 추측 보여주는 sql
	String sql3 = "SELECT * FROM (SELECT * FROM quiz ORDER BY guessdate DESC) WHERE ROWNUM <= 5";
	
			
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		System.out.println("db연결에 성공했습니다.");
		
		conn.setAutoCommit(false);
		
		if(session_id != null) {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, session_id);
			
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				System.out.println("rs 값이 있습니다.");
			} else {
				System.out.println("rs 값이 없습니다.");
			}
		} else if(request_id != null) {
			
		}
		
		conn.setAutoCommit(true);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
	<title>프로필 화면</title>
    <style>
        body { background-color: #eee; }
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
        .profilesection{
            width: 100%; height: 390px;
        }

            .top{
                width: 100%; height: 250px;
                position: relative;
            }
                .profileimg{
                    width:250px; height:250px;

                    margin: 0 auto;
                    margin-bottom: 10px;
                    border-radius: 150px;

                    background-color: #ddd;
                    cursor: pointer;
                }
                .btn{
                    width: 100px; height: 40px;

                    border-radius: 10px;
                    border: none;
                    box-shadow: 0 5px 0px rgba(0, 0, 0, 0.3);
                    background-color: #D8D8D8;

                    position: absolute;
                    right: 10px; top: 15px;

                    cursor: pointer;
                } 
                    .btn:active { box-shadow: none; }
                    #logout { display: none; }
        

        .profileid{
            width:300px; height:80px;  
            
            margin: 0 auto;
            margin-top: 10px;

            line-height: 80px;
            
            background-color: #ddd;
        }

        .short{
            width: 400px; height: 40px;
            margin: 0 auto;
            margin-top: 5px;

            line-height: 40px;
            
            background-color: #ddd;
            cursor: pointer;
        }

        .resultsection{
            width: 100%;
            
            display: flex;
            flex-flow: row wrap;
            justify-content: center;
        }
            .game{
                width: 250px; height: 150px;
                margin: 5px;
                
                position: relative;

                display: flex;
                flex-flow: column wrap;
                justify-content: center;
                align-items: center;

                border: 1px solid black;
                box-sizing: border-box;

                background-color: #ddd;
                cursor: pointer;
            }
                .game::before{
                    content: "";
                    opacity: 0.5;

                    position: absolute;
                    top: 0px; right: 0px; left: 0px; bottom: 0px;

                    background-color: black;
                }
                .game h2, .game h4 { padding: 0; margin: 0; color: white; position: relative; }
        
        .countsection {
            margin: 75px 0;
        }
            .countsection .count_highlight {
                color: #FBBC05;
                font-weight: bold;
            }
        
        .friendsection {
            margin: 100px 0 75px 0;
        }
            .guess {
                width: 125px; height: 35px;
                border-radius: 35px;

                display: inline-block;

                line-height: 35px;

                background-color: #D8D8D8;
                color: white;
            }

        .share{
            width: 300px; height: 50px;
            
            margin: 0 auto;
            margin-top: 10px;

            border-radius: 10px;
            border: none;
            box-shadow: 0 5px 0px rgba(0, 0, 0, 0.3);

            background-color: #D8D8D8;
            cursor: pointer;
        }
            .share:active { box-shadow: none; }

            #goto { display: none; }
            /* #share { display: none; } */

        footer h6 {
            margin-top: 100px;
            text-align: center;
            color: #ccc;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="profilesection">
        <div class="top">
            <div class="profileimg">
            </div>
            <button class="btn" id="login" onclick="location.href='loginPage.html'">로그인</button>
            <button class="btn" id="logout">로그아웃</button>
        </div>
        <div class="profileid">
            ID <%=(session_id != null) ? session_id : "GUEST" %>
        </div>
        <div class="short">
            #한줄소개#ExampleShortDescriptionOfMine
        </div>
    </div>
    <div class="resultsection">
        <div class="game" id="likeGame">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        <div class="game" id="placeGame">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        <div class="game" id="animalGame">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        <div class="game" id="activeGame">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        <div class="game" id="dislikeGame">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
    </div>
    <div class="countsection">
        <p class="countresult"><span class="count_highlight">n</span>명의 사람들이 <span class="count_highlight">#쩝쩝대는 사람</span>을 가장 싫어한다고 답했습니다.</p>        
        <p class="countresult"><span class="count_highlight">n</span>명의 사람들이 <span class="count_highlight">#잘생긴/예쁜 사람</span>을 가장 좋아한다고 답했습니다.</p>
        <p class="countresult"><span class="count_highlight">n</span>명의 사람들이 <span class="count_highlight">#고양이</span>를 가장 좋아한다고 답했습니다.</p>
        <p class="countresult"><span class="count_highlight">n</span>명의 사람들이 <span class="count_highlight">#아쿠아리움</span>을 가장 좋아한다고 답했습니다.</p>
        <p class="countresult"><span class="count_highlight">n</span>명의 사람들이 <span class="count_highlight">#그림그리기</span>를 가장 좋아한다고 답했습니다.</p>
    </div>
    <div class="friendsection">
        <div id="friendtitle"><h1>친구들의 예상</h1></div>
        <div class="friend">
            <img src="https://via.placeholder.com/35x35" alt="">
            홍길동: 
            <div class="guess">#쩝쩝대는</div>
            <div class="guess">#잘 웃는</div>
            <div class="guess">#강아지</div>
            <div class="guess">#영화관</div>
            <div class="guess">#잠자기</div>
        </div>
        <div class="friend">
            <img src="https://via.placeholder.com/35x35" alt="">
            홍길동: 
            <div class="guess">#쩝쩝대는</div>
            <div class="guess">#잘 웃는</div>
            <div class="guess">#강아지</div>
            <div class="guess">#영화관</div>
            <div class="guess">#잠자기</div>
        </div>
        <div class="friend">
            <img src="https://via.placeholder.com/35x35" alt="">
            홍길동: 
            <div class="guess">#쩝쩝대는</div>
            <div class="guess">#잘 웃는</div>
            <div class="guess">#강아지</div>
            <div class="guess">#영화관</div>
            <div class="guess">#잠자기</div>
        </div>
        <div class="friend">
            <img src="https://via.placeholder.com/35x35" alt="">
            홍길동: 
            <div class="guess">#쩝쩝대는</div>
            <div class="guess">#잘 웃는</div>
            <div class="guess">#강아지</div>
            <div class="guess">#영화관</div>
            <div class="guess">#잠자기</div>
        </div>
        <div class="friend">
            <img src="https://via.placeholder.com/35x35" alt="">
            홍길동: 
            <div class="guess">#쩝쩝대는</div>
            <div class="guess">#잘 웃는</div>
            <div class="guess">#강아지</div>
            <div class="guess">#영화관</div>
            <div class="guess">#잠자기</div>
        </div>
    </div>
    
    <% if(request_id == null & session_id == null) { %>
    	<button class="share" id="share">페이지 공유하기</button><br>
    <% } %>
    
    <% if(session_id != null) { %>
    	<button class="share" id="share">나의 프로필 공유하기</button><br>
    	<button class="share" id="quiz">문제지 제작하기</button>
    <% } %>
    
    <% if(request_id != null) { %>
    	<button class="share" id="goto" onclick="location.href='index.html'">나도 해보러 가기</button>
    <% } %>
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
        location.href="game01Page.html";
    });
    
    placeGame.addEventListener('click', function(){
        location.href="game02Page.html";
    });
    
    animalGame.addEventListener('click', function(){
        location.href="game03Page.html";
    });
    
    activeGame.addEventListener('click', function(){
        location.href="game04Page.html";
    });
    
    dislikeGame.addEventListener('click', function(){
        location.href="game05Page.html";
    });

    let share = document.querySelector("#share");
    let quiz = document.querySelector("#quiz");

    function inithref(url) {
        let url_array = url.split("/");
        let inittext = '';

        for(let i = 0; i < url_array.length-1; i++) {
            inittext += url_array[i] + "/";
        }

        return inittext;
    }
    
    
    
    share.addEventListener('click', function() {
        let copy = document.createElement('textarea');
        copy.value = inithref(window.document.location.href);
        
       	if(<%=(request_id == null && session_id == null) ? true : false%>) {
       		copy.value += "index.html";
       	} else copy.value += "index.html?id=" + <%=session_id %>;  //id 값은 jsp 로 가져오기
        document.body.appendChild(copy);

        copy.select();
        document.execCommand("copy");
        document.body.removeChild(copy);
    });

    quiz.addEventListener('click', function() {
        let copy = document.createElement('textarea');
        copy.value = inithref(window.document.location.href);
        copy.value += "sharequiz.html?id=" + <%=session_id %>;  //id 값은 jsp 로 가져오기
        document.body.appendChild(copy);

        copy.select();
        document.execCommand("copy");
        document.body.removeChild(copy);
    })

    var getCookie = function(name) {
        var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');      
        return value? value[2] : null;  
    };

    let result01 = getCookie("result01");
    let result02 = getCookie("result02");
    let result03 = getCookie("result03");
    let result04 = getCookie("result04");
    let result05 = getCookie("result05");

    if(result01 != null) {
        likeGame.style.backgroundColor = result01;
        likeGame.children[0].innerText = "#" + result01.toUpperCase().charAt(0) + result01.slice(1);
    }
    if(result02 != null) {
        placeGame.style.backgroundColor = result02;
        placeGame.children[0].innerText = "#" + result02.toUpperCase().charAt(0) + result02.slice(1);
    }
    if(result03 != null) {
        animalGame.style.backgroundColor = result03;
        animalGame.children[0].innerText = "#" + result03.toUpperCase().charAt(0) + result03.slice(1);
    }
    if(result04 != null) {
        activeGame.style.backgroundColor = result04;
        activeGame.children[0].innerText = "#" + result04.toUpperCase().charAt(0) + result04.slice(1);
    }
    if(result05 != null) {
        dislikeGame.style.backgroundColor = result05;
        dislikeGame.children[0].innerText = "#" + result05.toUpperCase().charAt(0) + result05.slice(1);
    }
    
</script>
</html>