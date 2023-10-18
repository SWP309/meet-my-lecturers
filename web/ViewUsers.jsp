<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, width=device-width" />

    <link rel="stylesheet" href="./ViewUsers.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Lexend:wght@400&display=swap"
    />
    <script>
            function submitSearchForm() {
                var form = document.querySelector('.searchfunction form');
                form.submit();
            }
    </script>
  </head>
  <body>
    <div class="admin-viewusersedited">
      <div class="admin-viewusers">
        <div class="fptu-eng-1-parent">
          <img
            class="fptu-eng-1-icon1"
            alt=""
            src="./public/UsersView/2021fptueng-11@2x.png"
          />

          <div class="frame-parent">
            <div class="frame-group">
              <div class="frame-container">
                <div class="wrapper">
                  <div class="div">+</div>
                </div>
                <div class="div">Add new User</div>
              </div>
              <div class="frame-div">
                <div class="logout-wrapper">
                  <img class="logout-icon1" alt="" src="./public/UsersView/logout1.svg" />
                </div>
                <div class="div">
                  <p class="logout2">Logout</p>
                </div>
              </div>
            </div>
            <img class="frame-child" alt="" src="./public/UsersView/group-33.svg" />
          </div>
        </div>
        <div class="searchfunction">
            <div class="search">
                        <div class="search-child" onclick="submitSearchForm()"></div>
            <div class="search1" onclick="submitSearchForm()">Search</div>
          <form action="MainController" method="POST">
              <input type="hidden" name="action" value="SearchUsers"/>
          
          <div class="lecture-4">
            <div class="searchbylec-parent">
              <img
                class="searchbylec-parent"
                alt=""
                src="./public/UsersView/searchbylec.svg"
                onclick="submitSearchForm()"
              />

              <div class="name"><input type="text" name="txtName" value="${param.txtName}" placeholder="Input name"/></div>
            </div>
            <div class="bysemester-parent">
              <img
                class="bysemester-icon"
                alt=""
                src="./public/UsersView/bysemester.svg"
              />

              <div class="roleid"><input type="text" name="txtRoleID" value="${param.txtRoleID}" placeholder="Input roleID"/></div>
            </div>
          </div>
      </form>  
        </div>
      </div>
            <div class="view-user-table">
                <c:if test="${not empty param.txtRoleID and empty param.txtName and not empty requestScope.USERS_BY_ROLEID}">
                    <div>
                        <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Role</th>
                            <th>UserID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Status</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.USERS_BY_ROLEID}" 
                                   var="user" varStatus="status">
                            <tr>
                    <form action="MainController" method="POST">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_ID}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtRoleID" 
                                                   value="${param.txtRoleID}" readonly="">
                                            <button type="submit" name="action"
                                                   value="UpdateUsers">Update</button>
                                        </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                    </div>
                
        </c:if>
              <c:if test="${empty param.txtRoleID and not empty param.txtName and not empty requestScope.USERS_BY_NAME}">
                  <div>
                      <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Role</th>
                            <th>UserID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Status</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.USERS_BY_NAME}" 
                                   var="user" varStatus="status">
                            <tr>
                                <form action="MainController">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_NAME}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtName" 
                                                   value="${param.txtName}" readonly="">
                                            <button type="submit" name="action"
                                                   value="UpdateUsers">Update</button>
                                        </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                  </div>
                
        </c:if>
              <c:if test="${not empty param.txtRoleID and not empty param.txtName and not empty requestScope.USERS_BY_NAME_AND_ID}">
                  <div>
                      <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Role</th>
                            <th>UserID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Status</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.USERS_BY_NAME_AND_ID}" 
                                   var="user" varStatus="status">
                            <tr>
                                <form action="MainController">
                                        <td>${status.count}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES_BY_NAME_AND_ID}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
                                        </td>
                                        <td>
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <input type="hidden" name="txtName" 
                                                   value="${param.txtName}" readonly="">
                                            <input type="hidden" name="txtRoleID" 
                                                   value="${param.txtRoleID}" readonly="">
                                            <button type="submit" name="action"
                                                   value="UpdateUsers">Update</button>
                                        </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                  </div>
                
        </c:if>
              <c:if test="${empty param.txtRoleID and empty param.txtName and not empty requestScope.USERS}">
                  <div>
                      <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>RoleID</th>
                            <th>Role Name</th>
                            <th>UserID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Status</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.USERS}" 
                                   var="user" varStatus="status">
                            <tr>
                                <form action="MainController">
                                        <td>${status.count}</td>
                                        <td>${user.roleID}</td>
                                        <td>
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var="role" items="${requestScope.ROLES}">
                                                <c:if test="${!breakLoop and role.roleID eq user.roleID}">
                                                    ${role.roleName}
                                                    <c:set var="breakLoop" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserID" 
                                                   value="${user.userID}"
                                                   readonly="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtUserName" 
                                                   value="${user.userName}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtEmail" 
                                                   value="${user.userEmail}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="text" name="txtPassword" 
                                                   value="${user.password}"
                                                   required="">
                                        </td>
                                        <td>
                                            <input type="checkbox" name="txtStatus" 
                                                   value="${user.userStatus}" ${user.userStatus ? 'checked' : ''}
                                                   >
                                        </td>
                                        <td>
                                            <!--<input type="hidden" name="action" value="SearchUsers">-->
                                            <input type="hidden" name="txtUserID" 
                                                   value="${user.userID}" readonly="">
                                            <button type="submit" name="action"
                                                   value="UpdateUsers">Update</button>
                                        </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                  </div>
                
        </c:if>      
        <c:if test="${empty requestScope.USERS_BY_ROLEID and empty requestScope.USERS_BY_NAME and empty requestScope.USERS_BY_NAME_AND_ID and empty requestScope.USERS}">
            <h3 style="color: red">${requestScope.VIEW_USERS_MESSAGE}</h3>
        </c:if>  
            </div>     
      <div class="backbutton">
        <div class="back">Back</div>
        <img class="back-icon" alt="" src="./public/UsersView/back.svg" />
      </div>
    </div>
  </body>
</html>
