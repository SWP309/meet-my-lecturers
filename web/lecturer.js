/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
var linkElement = document.createElement("link");
linkElement.rel = "stylesheet";
linkElement.href = "https://cdn.jsdelivr.net/npm/sweetalert2@10.16.3/dist/sweetalert2.min.css";
document.head.appendChild(linkElement);



function submitFormLogout() {
    var form = document.querySelector('.logout form');
    form.submit();
}
function submitFormCreate() {
    var form = document.querySelector('.CreateFSlot form');
    form.submit();
}
function submitFormSendEmail() {
    var form = document.querySelector('.sendMail form');
    form.submit();
}
function submitFormViewRequest() {
    var form = document.querySelector('.request-div form');
    form.submit();
}
function submitFormHideView() {
    var form = document.querySelector('.hideView form');
    form.submit();
}
function submitFormHomePage() {
    var form = document.querySelector('.returnHome form');
    form.submit();
}
function submitFormHomePageDiv() {
    var form = document.querySelector('.returnHomeDiv form');
    form.submit();
}

function submitFormHistory() {
    var form = document.querySelector('.history form');
    form.submit();
}
function submitFormViewLecturerProfile() {
    var form = document.querySelector('.lecturerProfile form');
    form.submit();
}
function submitForm() {
    var form = document.querySelector('.viewCreateSlot form');
    form.submit();
}
function submitFormImportTimetables() {
    var modal = document.getElementById("myModal");

    if (modal.style.display === "block") {
        modal.style.display = "none";
    } else {
        modal.style.display = "block";
    }
}

/* When the user clicks on the button, 
 toggle between hiding and showing the dropdown content */
function myFunctionDropdown() {
    var dropdown = document.getElementById("myDropdown");
    dropdown.classList.toggle("show");

    if (dropdown.classList.contains('show')) {
        dropdown.style.display = "flex";
        setTimeout(function () {
            dropdown.style.opacity = 1;
            dropdown.style.transform = "scaleY(1)";
        }, 10);
    } else {
        dropdown.style.opacity = 0;
        dropdown.style.transform = "scaleY(0)";
        setTimeout(function () {
            dropdown.style.display = "none";
        }, 400);
    }
}
