<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% 

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int game_no = Integer.parseInt(request.getParameter("game_no"));
	String game_dir;
	switch(game_no) {
		case 1 :
			game_dir = "좋아하는 사람 유형";
			break;
		case 2 :
			game_dir = "장소";
			break;
		case 3 : 
			game_dir = "동물";
			break;
		case 4 :
			game_dir = "활동";
			break;
		case 5 :
			game_dir = "싫어하는 사람 유형";
			break;
		
		default :
			game_dir = "동물";
			break;
	};
	
	String sql = "SELECT * FROM src WHERE game_no=?";
	String img_list = "";
	String name_list = "";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, game_no);
		rs = pstmt.executeQuery();

		while(rs.next()) {
			img_list += "'" + rs.getString("img_height") + "'" + ",";
			name_list += "'" + rs.getString("result_desc") + "'" + ",";
		}
		
		img_list.substring(0, img_list.length() - 1);
		name_list.substring(0, name_list.length() - 1);
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			rs.close();
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
  <title>밸런스 게임 진행</title>

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
        width: 700px; height: 100px;
        margin: 0 auto;

        --background-color: #ddd;
      }

      nav {
        height: 80px;

        font-size: 30px;
        line-height: 80px;
      }

      section {
        height: 500px;

        display: flex;
        flex-flow: row wrap;
        justify-content: center;
        align-items: center;
      }
        .selection {
          width: 300px; height: 500px;
          border: 1px solid black;
        }
          .selection > div:first-child { cursor: pointer; }
          .selection > .description {
            border-top: 1px solid black;
          }

          #left_select:hover, #right_select:hover { opacity: 0.5; }
          
        /* #left_select {
        } */

        #verse {
          display: inline-block;
          margin: 0 50px;
        }
          .result_selection {
            width: 700px; height: 500px;
            border: 1px solid black;

            display: none;
          }
            #result_select {
              width: 100%; height: 400px;
              background-color: #000;
              background-repeat: no-repeat;
              background-position: center;
            }
            #result_text {
              border-top: 1px solid black;
            }

          .description {
            font-size: 25px;
            font-weight: bold;
            line-height: 100px;
          }
        /* #right_select {
        } */
    footer h6 {
      margin-top: 100px;
      text-align: center;
      color: #ccc;
    }
  </style>
</head>
<body>
  <div class="container">
    <header><img src="images/타이틀/밸런스게임_<%=game_dir %>.png" alt="game_title" id="title"></h1></header>
    <nav id="battleRound">16강</nav>
    <section>
      <div class="selection" id="left">
        <!-- <img src="https://via.placeholder.com/300x400" alt="image01" id="left_select"> -->
        <div id="left_select" style="width: 300px; height: 400px;"></div>
        <div class="description" id="left_text">
          #SELECTION #LEFT_SIDE #EXAMPLE01
        </div>
      </div>
      <h2 id="verse">VS</h2>
      <div class="selection" id="right">
        <!-- <img src="https://via.placeholder.com/300x400" alt="image01" id="right_select"> -->
        <div id="right_select" style="width: 300px; height: 400px;"></div>
        <div class="description" id="right_text">
          #SELECTION #RIGHT_SIDE #EXAMPLE02
        </div>
      </div>
      
      <div class="result_selection" id="result">
        <div id="result_select"></div>
        <div class="description" id="result_text"></div>
      </div>
    </section>
  </div>

  <footer><h6>Copyright. 2022. 서혜원, 임소연, 이세원. All rights reserved.</h6></footer>
</body>
<script>
  var left_select =  document.querySelector("#left_select");
  var right_select = document.querySelector("#right_select");
  var left_text = document.querySelector("#left_text");
  var right_text = document.querySelector("#right_text");
  var result_text = document.querySelector("#result_text");

  var list = [];
  var imgList = [ <%=img_list %> ];
  var nameList = [ <%=name_list %> ];
  
  for(let index = 0; index < imgList.length - 1; index++) {
	  list[index] = index + 1;
  }

  
  var i = 0;

  function shuffle(array) {
    for (let index = array.length - 1; index > 0; index--) {
      // 무작위 index 값을 만든다. (0 이상의 배열 길이 값)
      const randomPosition = Math.floor(Math.random() * (index + 1));

      // 임시로 원본 값을 저장하고, randomPosition을 사용해 배열 요소를 섞는다.
      const temporary = array[index];
      array[index] = array[randomPosition];
      array[randomPosition] = temporary;
    }
  }

  function chooseOne(){
	console.log(list[i]);
    left_select.style.backgroundImage = "url('" + "images/<%=game_dir%>/" + imgList[list[i]-1] +  "')";
    right_select.style.backgroundImage = "url('" + "images//<%=game_dir%>/" + imgList[list[i+1]-1] +  "')";

    left_text.innerText = "#" + nameList[list[i]-1];
    right_text.innerText = "#" + nameList[list[i+1]-1];

    i += 1;
  }

  function setCookie(cookie_name, value, hours) {
    var exdate = new Date();
    exdate.setHours(exdate.getHours() + hours);

    var cookie_value = escape(value) + ((hours == null) ? '' : '; expires=' + exdate.toUTCString());
    document.cookie = cookie_name + '=' + cookie_value;
  }

  function initRound() {
    if(list.length == 1) {
      document.querySelector("#result_select").style.backgroundImage = "url('" + "images//<%=game_dir%>/" + imgList[list[0]-1] +  "')";

      battleRound.innerText = "최종 선택";
      document.querySelector(".result_selection").style.display = "block";
      result_text.style.display = "block";
      result_text.innerText = "#" + nameList[list[0]-1];

      document.querySelector("#left").style.display = "none";
      document.querySelector("#right").style.display = "none";
      document.querySelector("#verse").style.display = "none";

      setCookie("result0<%=game_no %>", list[0], 1);
      
      console.log(<%=game_no %>);
      console.log(list[0]);
      setTimeout(function() {location.href = "gameProcess.jsp?game_no=<%=game_no %>&result0<%=game_no %>=" + list[0];} , 2000);
      return;
    }

    if(list.length == 2) { document.querySelector("#battleRound").innerText = "결승전"; }
    else document.querySelector("#battleRound").innerText = list.length +"강";

    i = 0;
    shuffle(list);
    chooseOne();

    return;
  }

  shuffle(list); 
  chooseOne();

  // 0, 2, 4, 6, 8, ...
  left_select.addEventListener('click', function(){
    if(i >= list.length) {
      initRound();
      return;
    }

    list.splice(i, 1);
    
    console.log(list);
    console.log(i);

    if(i < list.length - 1) chooseOne();
    else {
      initRound();
    }
  });

  // 1, 3, 5, 7, 9 ...
  right_select.addEventListener('click', function(){
    if(i >= list.length) {
      initRound();
      return;
    }

    list.splice(i-1, 1);

    console.log(list);
    console.log(i);

    if(i < list.length - 1) chooseOne();
    else {
      initRound();
    }
  });

</script>
</html>