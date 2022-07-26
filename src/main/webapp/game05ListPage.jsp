<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<% 

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM src WHERE game_no=5";
	String list = "";
	
	String friendName = (String) request.getParameter("id");
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		System.out.println("db연결에 성공했습니다.");
		
		conn.setAutoCommit(false);
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		while(rs.next()) {
			list += "'" + rs.getString("img_width") + "'" + ",";
		}
		
		list.substring(0, list.length() - 1);

		conn.setAutoCommit(true);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>선택지 화면</title>

  <style>
  body {
    background-color: #eee;
  }

  .container {
    width: 850px; height: 1000px;

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

    background-color: #ddd;
  }
    header h1 { line-height: 100px; }

    .answerList {
      width: 100%;
      margin: 50px 0;

      display: flex;
      flex-flow: row wrap;
      justify-content: center;
    }
      .answer {
        width: 150px; height: 130px;
        margin: 10px;

        position: relative;

        border: 1px solid black;
        box-sizing: border-box;

        background-color: #ddd;
        cursor: pointer;

        overflow: hidden;
      }
        .answer img {
          width: 150px; height: 90px;
          
          position: absolute;
          left: 0; top: 0;
          
          background-repeat: no-repeat;
          background-position: center;
        }
        .answer p {
          width: 100%; height: 20px;
          padding: 10px 0; margin: 0;

          position: absolute;
          bottom: 0;

          text-align: center;
          background-color: white;
          border-top: 1px solid black;
        }
      
    input {
      width: 450px; height: 70px;
      margin: 5px 0;

      border-radius: 10px;
      border: none;

      background-color: #D8D8D8;
    }

      input[type="radio"]:checked + .answer {
        border: 5px solid blue;
      }

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
    <header><h1 id="title">가장 좋아하는 색깔 선택지들</h1></header>

     <form name="list" action="sharequiz.jsp?id=<%=friendName %>" method="POST" onsubmit="return checkForm()">
      <div class="answerList">
        <input type="radio" name="game05" id="answer01" value="1" hidden>
        <label for="answer01" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer02" value="2" hidden>
        <label for="answer02" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer03" value="3" hidden>
        <label for="answer03" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

       <input type="radio" name="game05" id="answer04" value="4" hidden>
        <label for="answer04" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer05" value="5" hidden>
        <label for="answer05" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer06" value="6" hidden>
        <label for="answer06" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer07" value="7" hidden>
        <label for="answer07" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer08" value="8" hidden>
        <label for="answer08" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer09" value="9" hidden>
        <label for="answer09" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer10" value="10" hidden>
        <label for="answer10" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer11" value="11" hidden>
        <label for="answer11" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer12" value="12" hidden>
        <label for="answer12" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer13" value="13" hidden>
        <label for="answer13" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer14" value="14" hidden>
        <label for="answer14" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer15" value="15" hidden>
        <label for="answer15" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>

        <input type="radio" name="game05" id="answer16" value="16" hidden>
        <label for="answer16" class="answer">
          <img src="https://via.placeholder.com/150x90" alt="img">
          <p>#예시문구입니다.</p>
        </label>
      </div>
      <input type="submit" value="선택">
    </form>
  </div>
  <footer><h6>Copyright. 2022. 서혜원, 임소연, 이세원. All rights reserved.</h6></footer>
</body>
<script>

  var dislikeList = [ <%=list %> ];

  function setCookie(cookie_name, value, days) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + days);
    // 설정 일수만큼 현재시간에 만료값으로 지정

    var cookie_value = escape(value) + ((days == null) ? '' : '; expires=' + exdate.toUTCString());
    document.cookie = cookie_name + '=' + cookie_value;
  }
  
  function checkForm() {
    for(let i = 0; i < list.game05.length; i++) {
      if(list.game05[i].checked == true) {
    	  setCookie("game05", i+1 , 1);
    	  return true;
      }
    }

    return false;
  }
  
  //console.log(list.game05);
  
  for(let i = 0; i < list.game05.length; i++) {
	  //console.log(list.game05[i].nextElementSibling.firstElementChild);
	  list.game05[i].nextElementSibling.firstElementChild.src = "images/싫어하는 사람 유형/" + dislikeList[i];
	  list.game05[i].nextElementSibling.lastElementChild.innerText = "#" + dislikeList[i].split("_")[0];
  }
  
</script>

</html>