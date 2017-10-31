<%--
  Created by IntelliJ IDEA.
  User: xsyzx
  Date: 2017/10/24
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Welcome</title>
        <style>
            body {
                background: url(img/index.jpg) no-repeat center;
                background-size: contain;
            }
            #overall {
                margin-top: 9%;
                margin-left: 25%;
            }
            #footer {
                margin-top: 1%;
                margin-left: 7%;
            }
            #psw {
                margin-left:16px;
            }
            input {
                opacity: 0.7;
            }
            p {
                color: snow;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }
            p:hover {
                cursor: default;
            }
            #login:hover {
                cursor: pointer;
                background-color: cornsilk;
            }
            #regist:hover {
                cursor: pointer;
                background-color: cornsilk;
            }
        </style>
    </head>
    <body>
        <div id="overall">
            <div>
                <p>Weclome to our Gods Alliance</p>
                <p>用户名: <input type="text" placeholder="请输入用户名"></p>
                <p>密码 :<input type="text" placeholder="请输入密码" id="psw"></p>
            </div>
            <div id="footer">
                <input type="button" value="登入" id="login">
                <input type="button" value="注册" id="regist">
            </div>
        </div>
    </body>
    <script type="text/javascript" src="scripts/jquery.min.js"></script>
    <script>
        $('#regist').on('click',function(){
            location.href = "user/showRegist.do";
        });
    </script>
</html>
