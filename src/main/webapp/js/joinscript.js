var openWin;
function chkID() {
  if(document.getElementById("id").value == null || document.getElementById("id").value == undefined || document.getElementById("id").value == "") { 
    document.getElementById("id").focus();
  } else {
    openWin = window.open("chkDuplicateID.jsp?id=" + document.getElementById("id").value, "아이디 중복 체크", "width=400px, height=250px, scrollbars=no, toolbar=no, resizeable=no, menubar=no, location=no");
  }
  
  openWin.addEventListener('beforeunload', debounce(function () {
		checkId();
	}));
}

function checkMessage() {
  if(document.querySelector("#chk").checked){
    document.querySelector("#chk").checked = false;
    document.querySelector("#duplicationChk").disabled = false;
    chkDupliEl.innerText = "아이디 중복 확인을 진행해주세요.\n";
  }
}


let idEl = document.querySelector("#id");
let passwdEl = document.querySelector("#passwd");
let passwdConfirmEl = document.querySelector("#passwdConfirm");
let chkDupliEl =  document.getElementById("chkResult");
let nameEl = document.querySelector("#name");

let form = document.querySelector("#signup");

// input field 와 form을 선택하기 위해서 document.querySelector() method를 사용


const checkId = () => {

    let valid = false;
	showError(idEl, '');
    
    const min = 4;
    const max = 15;
    const id = idEl.value.trim();
	
	console.log("isRequired(id) " + isRequired(id));
	console.log("isBetween(id.length, min, max) " + isBetween(id.length, min, max));
	console.log("isIdValid(id) " + isIdValid(id));
	console.log("document.querySelector('#chk').checked == true " + (document.querySelector("#chk").checked == true));
	console.log("document.querySelector('#duplicationChk').disabled == false " + (document.querySelector("#duplicationChk").disabled == false));
	
    if (!isRequired(id)) {
	
        showError(idEl, '아이디를 입력해주세요.');
        
    } else if (!isBetween(id.length, min, max)) {
	
		console.log("id.length" + id.length);
		console.log("isBetween(id.length, min, max)" + isBetween(id.length, min, max));
        showError(idEl, `아이디는 최소 ${min}~${max}자로 구성하실 수 있습니다.`);
        
    } else if (!isIdValid(id)) {
	
        showError(idEl, '아이디는 영문자+숫자 조합으로만 구성하실 수 있습니다. ');
        
    } else if(!document.querySelector("#chk").checked == true) {
		console.log("document.querySelector('#chk').checked");
		showError(idEl, '');
    	chkDupliEl.innerHTML= "아이디 중복 확인을 진행해주세요.\n";
    	
	} else if(document.querySelector("#duplicationChk").disabled == false) {
		console.log("document.querySelector('#duplicationChk').disabled");
		showError(idEl, '');
		chkDupliEl.innerHTML= "이미 사용 중인 아이디입니다.";
		
	} else {
		console.log("id OK");
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

const checkNickname = () => {
	let valid = false;
	const min = 1, max = 21;
	const nameLimit = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
	const name = nameEl.value.trim();
	
	let totalLength = 0;
	for(let i = 0; i < name.length; i++) {
		let currentText = name[i];
		console.log(name[i]);
		if(nameLimit.test(currentText)) {
			totalLength += 3;
		} else {
			totalLength++;	
		}
	}
	
	if(!isRequired(name)) {
		showError(nameEl, '닉네임을 입력해주세요.');
	} else if(!isBetween(totalLength, min, max)) {
		showError(nameEl, '닉네임은 최소 1글자부터 최대 한글 7글자, 영어 21글자로 구성하실 수 있습니다.');
	} else {
		showSuccess(nameEl);
		valid = true;
	}
	
	return valid;
}

const isIdValid = (id) => {
    const re =  /^[A-Za-z0-9]+$/;
    return re.test(id);
   
};

const isRequired = value => (value == '' || value == null) ? false : true;
// input값이 비어있을때 isRequired() function 은 true 리턴
const isBetween = (length, min, max) => length < min || length > max ? false : true;
// length가 minimum과 maximum 조건에 충족하지 않을 때 isBetween() function은 flase리턴 


const showError = (input, message) => {
    // get the form-field element which is the <div> element that contains the form-field class
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
    
    //addEventListener를 사용해서 submit 에 관한 event listener를 form 에 추가
    e.preventDefault();
    // e.preventDefault() 를 불러줌으로써 한번 이미 submit이 된 상태에서 submit 버튼을 클릭했을 때 폼이 제출되지 않도록


    // validate forms
    let isIdValid = checkId(),
        isPasswdValid = checkPasswd(),
        isPasswdConfirmValid = checkPasswdConfirm(),
        isNameValid = checkNickname();
    
	console.log(isIdValid + ", " + isPasswdValid + ", " + isPasswdConfirmValid + ", " + isNameValid);

    let isFormValid = isIdValid &&
        isPasswdValid &&
        isPasswdConfirmValid && isNameValid;

	console.log(isFormValid);
	
    // submit to the server if the form is valid
    if (isFormValid) {
		form.submit();
    }
});


const debounce = (fn, delay = 250) => {
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
            checkPasswdConfirm();
            break;
        case 'passwdConfirm':
            checkPasswdConfirm();
            break;
        case 'name':
        	checkNickname();
        	break;
    }
}));