let openWin;
function chkID() {
  if(document.getElementById("id").value == null || document.getElementById("id").value == undefined || document.getElementById("id").value == "") { 
    document.getElementById("id").focus();
  } else {
    openWin = window.open("chkDuplicateID.jsp?id=" + document.getElementById("id").value, "아이디 중복 체크", "width=400px, height=250px, scrollbars=no, toolbar=no, resizeable=no, menubar=no, location=no");
  }
}

function chkForm(){

  if(!document.querySelector("#chk").checked) {
    return false;
  }

  if(document.querySelector("#passwd").value != document.querySelector("#passwdConfirm").value)
  {
    document.querySelector("#chkConfirm").innerText = "비밀번호가 서로 다릅니다. 다시 확인해주세요.";
    document.querySelector("#passwdConfirm").focus();
    return false;
  } else {
    document.querySelector("#chkConfirm").innerText = "비밀번호를 사용할 수 있습니다.";
  }

  return true;
}

function checkMessage() {
  if(document.querySelector("#chk").checked){
    document.querySelector("#chk").checked = false;
    document.querySelector("#duplicationChk").disabled = false;
    document.querySelector("#chkResult").innerText = "아이디 중복 확인을 진행해주세요.";
  }
}