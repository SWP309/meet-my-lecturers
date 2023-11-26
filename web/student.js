
function confirmCancel(bookingID) {
    if (confirm('Are you sure to cancel this booking')) {
        // S? d?ng bi?n `bookingID` ? ?ây n?u c?n
        window.location.href = 'MainController?action=cancel&bookingID=' + bookingID;
    }
}

function submitForm() {
    var form = document.querySelector('.bookingview form');
    form.submit();
}
function submitFormLogout() {
    var form = document.querySelector('.logout form');
    form.submit();
}
function submitFormRequest() {
    var form = document.querySelector('.request form');
    form.submit();
}
function submitSearchForm() {
    var form = document.querySelector('.searchfunction form');
    form.submit();
}
function submitFormViewLecturer() {
    var form = document.querySelector('.viewLecturer form');
    form.submit();
}
function submitFormRequestStatus() {
    var form = document.querySelector('.requestViewStatus form');
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
function confirmCancel() {
    var result = confirm("Are you sure about cancel your booking ?");
    if (result) {
        // N?u ng??i dùng ch?n OK, chuy?n ??n trang MainController ?? x? lý hành ??ng "cancel".
        // Ví d?:
        window.location.href = "MainController?action=cancel&bookingID=" + document.querySelector('[name="bookingID"]').value;
    } else {
        // N?u ng??i dùng ch?n Cancel, không làm gì c?.
//                    alert("Booking cancel canceled!"); // Hi?n th? thông báo cho ng??i dùng
        // N?u ng??i dùng ch?n Cancel, ng?n ch?n chuy?n h??ng trang m?c ??nh sau ?ó.
        event.preventDefault();
    }
}

function myFunction() {
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
;