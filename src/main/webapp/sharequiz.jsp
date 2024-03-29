<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% 
	Cookie[] cookies = request.getCookies();

	int[] games = new int[5];
	String[] guess = new String[5];
	String[] guess_text = new String[5];
	String friendId = (String)request.getParameter("id");
	String friendName = "";

	if(cookies != null) {
		for(int i = 0; i < cookies.length; i++) {
			switch(cookies[i].getName()){
				case "game01":
					games[0] = Integer.parseInt(cookies[i].getValue());
					break;
				case "game02":
					games[1] = Integer.parseInt(cookies[i].getValue());
					break;
				case "game03":
					games[2] = Integer.parseInt(cookies[i].getValue());
					break;
				case "game04":
					games[3] = Integer.parseInt(cookies[i].getValue());
					break;
				case "game05":
					games[4] = Integer.parseInt(cookies[i].getValue());
					break;
					
				default: continue;
			}
		}
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet[] rs = new ResultSet[5] ;
	ResultSet rs2 = null;
	
	String[] sqls = {"SELECT * FROM src WHERE game_no=1 AND result_no=?",
					"SELECT * FROM src WHERE game_no=2 AND result_no=?",
					"SELECT * FROM src WHERE game_no=3 AND result_no=?",
					"SELECT * FROM src WHERE game_no=4 AND result_no=?",
					"SELECT * FROM src WHERE game_no=5 AND result_no=?" };

	String sql = "SELECT name FROM member WHERE member.id=?";
	
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		for(int i = 0; i < sqls.length; i++) {
			pstmt = conn.prepareStatement(sqls[i]);
			if(games[i] == 0) continue;
			pstmt.setInt(1, games[i]);
			rs[i] = pstmt.executeQuery();
			
			rs[i].next();
			guess[i] = rs[i].getString("img_width");
			guess_text[i] = rs[i].getString("result_desc");
		}

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, friendId);
		
		rs2 = pstmt.executeQuery();
		if(rs2.next()) {
			friendName = rs2.getString(1);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			for(int i = 0; i < rs.length; i++) {
				if(games[i] == 0) continue;
				rs[i].close(); 
			}
			rs2.close();
			pstmt.close();
			conn.close();
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
  <meta property="og:image" content="https://via.placeholder.com/200x150">
  <meta property="ogLdescription" content="<%=friendName %>님은 어떤 선택을 했을까요? 지금 맞춰보세요.">
  <title>문제지 화면</title>

  <style>
	 @font-face {
	    font-family: 'SEBANG Gothic Bold';
	    src: url('fonts/sebang/SEBANG-Gothic-Bold.woff') format('woff');
	}
	@font-face {
	    font-family: 'SEBANG Gothic Regular';
	    src: url('fonts/sebang/SEBANG-Gothic.woff') format('woff');
	}
	
	*{
		font-family: 'SEBANG Gothic Regular';
	}
	
    body { background-color: #eee; }
      .container{
          width: 850px; height: 850px;

          margin: 0 auto; margin-top: 1vh;
          padding: 35px;
          box-sizing: border-box;

          text-align: center;

          border-radius: 80px;
          box-shadow: 0px 50px 10px rgba(0,0,0,0.3);

          background-color: white;
      }

    header {
      width: 700px; height: 100px;
      
      margin: 0 auto;
      margin-bottom: 50px;
    }
      header h1 {
      	<%if(friendName.length() > 10) {%>
      		font-size: 35px;      
	    <%} else { %>
	    	font-size: 50px;
	    <%}%>
	    
      	line-height: 100px;
      	font-family: 'SEBANG Gothic Bold';
      }
      	#friendName {
      	<%if(friendName.length() > 7) {%>
      		font-size: 35px;      
	    <%} else { %>
	    	font-size: 50px;
	    <%}%>
	    
	      	line-height: 100px;
	      	font-family: 'SEBANG Gothic Bold';
      	}

    input {
      width: 450px; height: 70px;
      margin: 5px 0;

      border-radius: 20px;
      border: none;
		
	  text-align: center;
	  font-size: 30px;
	  font-family: 'SEBANG Gothic Bold';
	  
	  color: white;
      background-color: #D8D8D8;
    }

    .sections{
        width: 100%;
        margin: 25px 0 75px 0;
        
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
                opacity: 0.3;

                position: absolute;
                top: 0px; right: 0px; left: 0px; bottom: 0px;

                background-color: black;
            }
            .game h2, .game h4 { padding: 0; margin: 0; color: white; position: relative; }
            
          input[type="submit"] {
            border-radius: 10px;
            border: none;
            box-shadow: 0 5px 0px rgba(0, 0, 0, 0.3);
          
            cursor: pointer;
          }
            input[type="submit"]:active { box-shadow: none; }
            
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
      <h1><span id=friendName><%=friendName %></span>님의 선택은?</h1>
    </header>

    <form name="games" action="quizProcess.jsp" method="POST" onsubmit="return checkForm()">
      <input type="text" name="id" id="id" value="<%=friendId %>" hidden>
      <input type="text" name="name" id="name" placeholder="닉네임 입력" required>

      <div class="sections">
        <input type="text" name="likeGame" hidden>
        <div class="game" id="likeGame" style="background-image: url('images/좋아하는 사람 유형/<%=guess[0] %>');">
            <h2>#가장 좋아하는<br>사람 유형은?</h2>
            <h4><img src="images/plus.png" width="35px" style="margin-top: 10px"></h4>
        </div>
        
        <input type="text" name="placeGame" hidden>
        <div class="game" id="placeGame" style="background-image: url('images/장소/<%=guess[1] %>');">
            <h2>#가장 좋아하는<br>장소는?</h2>
            <h4><img src="images/plus.png" width="35px" style="margin-top: 10px"></h4>
        </div>
        
        <input type="text" name="animalGame" hidden>
        <div class="game" id="animalGame" style="background-image: url('images/동물/<%=guess[2] %>');">
            <h2>#가장 좋아하는<br>동물은?</h2>
            <h4><img src="images/plus.png" width="35px" style="margin-top: 10px"></h4>
        </div>
        
        <input type="text" name="activeGame" hidden>
        <div class="game" id="activeGame" style="background-image: url('images/활동/<%=guess[3] %>');">
            <h2>#가장 좋아하는<br>활동은?</h2>
            <h4><img src="images/plus.png" width="35px" style="margin-top: 10px"></h4>
        </div>
        
        <input type="text" name="dislikeGame" hidden>
        <div class="game" id="dislikeGame" style="background-image: url('images/싫어하는 사람 유형/<%=guess[4] %>');">
            <h2>#가장 싫어하는<br>사람 유형은?</h2>
            <h4><img src="images/plus.png" width="35px" style="margin-top: 10px"></h4>
        </div>
      </div>

      <input type="submit" value="제출">
    </form>
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
        location.href="gameListPage.jsp?id=<%=friendId %>&game_no=1";
    });
    
    placeGame.addEventListener('click', function(){
        location.href="gameListPage.jsp?id=<%=friendId %>&game_no=2";
    });
    
    animalGame.addEventListener('click', function(){
        location.href="gameListPage.jsp?id=<%=friendId %>&game_no=3";
    });
    
    activeGame.addEventListener('click', function(){
        location.href="gameListPage.jsp?id=<%=friendId %>&game_no=4";
    });
    
    dislikeGame.addEventListener('click', function(){
        location.href="gameListPage.jsp?id=<%=friendId %>&game_no=5";
    });

    var getCookie = function(name) {
        var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');      
        return value? value[2] : null;  
    };
    
    if(<%=games[0] %> != 0) {
    	games.likeGame.value = '<%=games[0] %>';
    	likeGame.firstElementChild.innerText = "#" + '<%=guess_text[0] %>';
    	likeGame.children[1].innerHTML = "#좋아하는 사람 유형";
    }
    if(<%=games[1] %> != 0) {
    	games.placeGame.value = '<%=games[1] %>';
    	placeGame.firstElementChild.innerText = "#" + '<%=guess_text[1] %>';
    	placeGame.children[1].innerHTML = "#좋아하는 장소";
    }
    if(<%=games[2] %> != 0) {
    	games.animalGame.value = '<%=games[2] %>';
    	animalGame.firstElementChild.innerText = "#" + '<%=guess_text[2] %>';
    	animalGame.children[1].innerHTML = "#좋아하는 동물";
    }
    if(<%=games[3] %> != 0) {
    	games.activeGame.value = '<%=games[3] %>';
    	activeGame.firstElementChild.innerText = "#" + '<%=guess_text[3] %>';
    	activeGame.children[1].innerHTML = "#좋아하는 활동";
    }
    if(<%=games[4] %> != 0) {
    	games.dislikeGame.value = '<%=games[4] %>';
    	dislikeGame.firstElementChild.innerText = "#" + '<%=guess_text[4] %>';
    	dislikeGame.children[1].innerHTML = "#싫어하는 사람 유형";
    }

  function checkForm() {
    if(games.likeGame.value == ("")) {
      alert("가장 좋아하는 사람 유형을 예상해주세요.");
      return false;
    }

    if(games.placeGame.value == ("")) {
      alert("가장 좋아하는 장소를 예상해주세요.");
      return false;
    }

    if(games.animalGame.value == ("")) {
      alert("가장 좋아하는 동물을 예상해주세요.");
      return false;
    }

    if(games.activeGame.value == ("")) {
      alert("가장 좋아하는 활동을 예상해주세요.");
      return false;
    }

    if(games.dislikeGame.value == ("")) {
      alert("가장 싫어하는 사람 유형을 예상해주세요.");
      return false;
    }

    return true;
  }

</script>
</html>