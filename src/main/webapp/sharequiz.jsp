<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% 
	String[] games = { request.getParameter("game01"), request.getParameter("game02"), request.getParameter("game03"), request.getParameter("game04"), request.getParameter("game05") };
	String[] guess = new String[5];

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet[] rs = new ResultSet[5] ;
	String[] sqls = {"SELECT * FROM src WHERE game_no=1 AND result_no=?",
					"SELECT * FROM src WHERE game_no=2 AND result_no=?",
					"SELECT * FROM src WHERE game_no=3 AND result_no=?",
					"SELECT * FROM src WHERE game_no=4 AND result_no=?",
					"SELECT * FROM src WHERE game_no=5 AND result_no=?" };

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		System.out.println("db연결에 성공했습니다.");
		
		conn.setAutoCommit(false);
		
		for(int i = 0; i < 5; i++) {
			pstmt = conn.prepareStatement(sqls[i]);
			if(games[i] == null) continue;
			pstmt.setString(1, games[i]);
			rs[i] = pstmt.executeQuery();
			
			rs[i].next();
			guess[i] = rs[i].getString("img_width");
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
  <title>문제지 화면</title>

  <style>
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
      width: 500px; height: 100px;
      background-color: #ddd;
      margin: 0 auto;
      margin-bottom: 50px;
    }
      header h1 { line-height: 100px; }

    input {
      width: 450px; height: 70px;
      margin: 5px 0;

      border-radius: 10px;
      border: none;

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
                opacity: 0.5;

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
      <h1>홍길동님의 선택은?</h1>
    </header>

    <form name="games" action="" method="GET" onsubmit="return checkForm()">
      <input type="text" name="name" id="name" placeholder="닉네임 입력" required>

      <div class="sections">
        <input type="text" name="likeGame" hidden>
        <div class="game" id="likeGame" style="background-image: url('<%=guess[0] %>');">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        
        <input type="text" name="placeGame" hidden>
        <div class="game" id="placeGame" style="background-image: url('<%=guess[1] %>');">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        
        <input type="text" name="animalGame" hidden>
        <div class="game" id="animalGame" style="background-image: url('<%=guess[2] %>');">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        
        <input type="text" name="activeGame" hidden>
        <div class="game" id="activeGame" style="background-image: url('<%=guess[3] %>');">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
        </div>
        
        <input type="text" name="dislikeGame" hidden>
        <div class="game" id="dislikeGame" style="background-image: url('<%=guess[4] %>');">
            <h2>#Example</h2>
            <h4>#textMessage</h4>
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
        location.href="game01ListPage.html";
    });
    
    placeGame.addEventListener('click', function(){
        location.href="game02ListPage.html";
    });
    
    animalGame.addEventListener('click', function(){
        location.href="game03ListPage.jsp";
    });
    
    activeGame.addEventListener('click', function(){
        location.href="game04ListPage.html";
    });
    
    dislikeGame.addEventListener('click', function(){
        location.href="game05ListPage.html";
    });

    

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