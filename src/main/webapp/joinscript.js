let openWin;
function chkID() {
	console.log("진행은 됨");
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




let idEl = document.querySelector("#id");
let passwdEl = document.querySelector("#passwd");
let passwdConfirmEl = document.querySelector("#passwdConfirm");

let form = document.querySelector("#signup");


const checkId = () => {

    let valid = false;

    const min = 4,
        max = 15;
    const id = idEl.value.trim();

    if (!isRequired(id)) {
        showError(idEl, '아이디를 입력해주세요.');
    } else if (!isBetween(id.length, min, max)) {
        showError(idEl, `아이디는 최소 ${min}~${max}자로 구성하실 수 있습니다.`)
    } else if (!isIdValid(id)) {
        showError(idEl, '아이디는 영문자+숫자 조합으로만 구성하실 수 있습니다. ')
    } else {
        showSuccess(idEl);
        valid = true;
    }
    return valid;
};

const checkPasswd = () => {

    let valid = false;
    const min = 4,
        max = 20;
    const passwd = passwdEl.value.trim();
    
     if (!isRequired(passwd)) {
        showError(passwdEl, '비밀번호를 입력해주세요.');
    } else if (!isBetween(passwd.length, min, max)) {
        showError(passwdEl, `비밀번호는 최소 ${min}~${max}자로 구성하실 수 있습니다.`)
    } else {
        showSuccess(passwdEl);
        valid = true;
    }
    return valid;
};

const checkPasswdConfirm = () => {
    let valid = false;
    // check confirm password
    const passwdConfirm = passwdConfirmEl.value.trim();
    const passwd = passwdEl.value.trim();

    if (!isRequired(passwdConfirm)) {
        showError(passwdConfirmEl, '비밀번호를 다시 입력해주세요.');
    } else if (passwd !== passwdConfirm) {
        showError(passwdConfirmEl, '비밀번호가 일치하지 않습니다.');
    } else {
        showSuccess(passwdConfirmEl);
        valid = true;
    }

    return valid;
};

const isIdValid = (id) => {
    const re =  /^[A-Za-z0-9]+$/;
    return re.test(id);
   
};

const isRequired = value => value === '' ? false : true;
const isBetween = (length, min, max) => length < min || length > max ? false : true;



const showError = (input, message) => {
    // get the form-field element
    const formField = input.parentElement;
    // add the error class
    formField.classList.remove('success');
    formField.classList.add('error');

    // show the error message
    const error = formField.querySelector('small');
    error.textContent = message;
};

const showSuccess = (input) => {
    // get the form-field element
    const formField = input.parentElement;

    // remove the error class
    formField.classList.remove('error');
    formField.classList.add('success');

    // hide the error message
    const error = formField.querySelector('small');
    error.textContent = '';
}


form.addEventListener('submit', function (e) {
    // prevent the form from submitting
    e.preventDefault();


    // validate forms
    let isIdValid = checkId(),
        isPasswdValid = checkPasswd(),
        isPasswdConfirmValid = checkPasswdConfirm();
    
	console.log(isIdValid + ", " + isPasswdValid + ", " + isPasswdConfirmValid);

    let isFormValid = isIdValid &&
        isPasswdValid &&
        isPasswdConfirmValid;

	console.log(isFormValid);
	
    // submit to the server if the form is valid
    if (isFormValid) {
		form.submit();
    }
});


const debounce = (fn, delay = 500) => {
    let timeoutId;
    return (...args) => {
		console.log("debounce RUN");
        // cancel the previous timer
        if (timeoutId) {
            clearTimeout(timeoutId);
        }
        // setup a new timer
        timeoutId = setTimeout(() => {
            fn.apply(null, args)
        }, delay);
    };
};
// 
form.addEventListener('input', debounce(function (e) {
	console.log(e.target.id);
    switch (e.target.id) {
        case 'id':
            checkId();
            break;
        case 'passwd':
            checkPasswd();
            break;
        case 'passwdConfirm':
            checkPasswdConfirm();
            break;
    }
}));