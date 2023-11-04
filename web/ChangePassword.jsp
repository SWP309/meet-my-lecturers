<%-- 
    Document   : ChangePassword
    Created on : Nov 3, 2023, 9:51:52 PM
    Author     : Minh Khang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thay đổi mật khẩu</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <meta charset="UTF-8">

</head>
<body>
    <div class="container">
        <h1 class="mt-5">Thay đổi mật khẩu</h1>
        <form action="process_password_change.php" method="post">
            <div class="form-group">
                <label for="old_password">Mật khẩu cũ:</label>
                <input type="password" class="form-control" id="old_password" name="old_password">
            </div>
            <div class="form-group">
                <label for="new_password">Mật khẩu mới:</label>
                <input type="password" class="form-control" id="new_password" name="new_password">
            </div>
            <div class="form-group">
                <label for="confirm_password">Xác nhận mật khẩu mới:</label>
                <input type="password" class="form-control" id="confirm_password" name="confirm_password">
            </div>
            <button type="submit" class="btn btn-primary">Thay đổi mật khẩu</button>
        </form>
    </div>
</body>
</html>
