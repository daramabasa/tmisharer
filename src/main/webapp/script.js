let coverPreview = document.getElementById('coverPreview');
let cover = document.getElementById('cover');

coverPreview.addEventListener('click',_=>cover.click());

cover.addEventListener("change",_=>{
    let file = cover.files[0];
    let reader = new FileReader();
    reader.onload = function (){
        coverPreview.src = reader.result;
    }
    reader.readAsDataURL(file);
});