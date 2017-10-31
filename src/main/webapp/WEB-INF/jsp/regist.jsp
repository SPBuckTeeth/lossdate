<%--
  Created by IntelliJ IDEA.
  User: xsyzx
  Date: 2017/10/25
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Regist</title>

    <style>
        .warning {
            color: red;
            text-align: center;
        }
        body {
            background: url(<%=request.getContextPath() %>/img/6.jpg) no-repeat center;
            background-size: contain;
        }
        #overall {
            margin-top: 9%;
            margin-left: 39%;
        }
        input {
            opacity: 0.7;
        }
        p, #reload {
            color: lightseagreen;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
        p:hover {
            cursor: default;
        }
        #footer {
            margin-top:2%;
            margin-left: 12%;
        }
        #nickName,#psw,#mailAddress {
            margin-left: 32px;
        }
        #userName,#vertification {
            margin-left: 16px;
        }
        #vertificationCode {
            height:50px;
            opacity: 0.5;
            margin-left: 73px;
        }
        #reload:hover {
            color: blueviolet;
            cursor: pointer;
        }
        #back:hover {
            cursor: pointer;
            background-color: cornsilk;
        }
        #confirm:hover {
            cursor: pointer;
            background-color: cornsilk;
        }

    </style>
</head>
<body>
    <div id="overall">
        <div id="infoBlock">
            <p style="margin-left:59px;color: snow;">To be one of us</p>
            <p>用户名: <input type="text" placeholder="请输入用户名" id="userName"><span class="warning" id="warning1"></span></p>
            <p>昵称: <input type="text" placeholder="请输入昵称" id="nickName"></p>
            <p>邮箱: <input type="text" placeholder="请输入邮箱" id="mailAddress"><span class="warning" id="warning5"></span></p>
            <p>密码: <input type="password" placeholder="请输入密码" id="psw"><span class="warning" id="warning2"></span></p>
            <p>确认密码: <input type="password" placeholder="请再次输入密码" id="pswsed"><span class="warning" id="warning3"></span></p>
            <p>验证码:
                <input type="text" placeholder="请输入验证码" id="vertification">
                <span class="warning" id="warning4"></span>
            </p>
            <div>
                <img src="<%=request.getContextPath()%>/user/vertification.do" id="vertificationCode">
                <span id="reload">看不清?点击换一张</span>
            </div>

        </div>
        <div id="footer">
            <input type="button" value="返回" id="back">
            <input type="button" value="确认" id="confirm">
        </div>
    </div>
    <script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery-1.9.1.min.js"></script>
    <script>
        var SUCCESS = 0;
        $(function(){
            //用户名检查
            $('#userName').blur(checkUserName);
            //密码检查
            $('#psw').blur(checkPsw);
            //确认密码检查
            $('#pswsed').blur(checkPswsed);
            //验证码检查
            $('#vertification').blur(checkVertificationCode);
            //邮箱检查
            $('#mailAddress').blur(checkMailAddress);
        });

        /**
         * 邮箱格式验证
         * 10/30/2017 PM
         */
        function checkMailAddress() {
            var mailAddress = $('#mailAddress').val();
            var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
            if(mailAddress == "") {
                $('#warning5').html("邮箱不能为空").css("color","red");
            } else if(!reg.test(mailAddress)) {
                $('#warning5').html("邮箱格式有误").css("color","red");
            } else {
                $('#warning5').html("通过").css("color","green");
            }
        }

        /**
         * 验证码验证
         * 10/30/2017 PM
         */
        function checkVertificationCode() {
            var code = $('#vertification').val();
            if(code == "") {
                $('#warning4').html("请输入验证码").css("color","red");
            } else {
                var url = "checkVertification.do";
                var data = {'code':code};
                $.post(url,{data:JSON.stringify(data)},function(result) {
                    if(result == 'True') {
                        $('#warning4').html("通过").css("color","green");
                    } else {
                        $('#warning4').html("验证码错误").css("color","red");
                    }
                });
            }
        }

        /**
         *  刷新验证码
         * 10/27/2017 PM
         */
        $('#reload').on('click',function(){
            var randomNum = Math.random() + 1;
            var reloadUrl = "@lossdate" + randomNum;
            $('#vertificationCode').attr('src',"<%=request.getContextPath()%>/user/vertification.do?" + reloadUrl);
            $('#warning4').html("请输入验证码").css("color","red");
            $('#vertification').focus().val("");
        });

        /**
         * 返回登入页
         * 10/26/2017 PM
         */
        $('#back').on("click",function(){
            location.href = "<%=request.getContextPath() %>/index.jsp";
        });

        /**
         * 用户名格式检查
         * 10/26/2017 PM
         */
        function checkUserName() {
            var reg = /^[\u4e00-\u9fa5_\w]{3,8}$/;
            var name = $('#userName').val();
            if(!reg.test(name)) {
                $('#warning1').html("请输入3~8个字符").css("color","red");
            } else {
                $('#warning1').html("通过").css("color","green");
            }
        }

        /**
         * 密码格式检查
         * 10/26/2017 PM
         */
        function checkPsw() {
            var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[\w\W]{8,16}$/;
            var psw = $('#psw').val();
            if(!reg.test(psw)) {
                $('#warning2').html("请输入8~16个字符,包含大小写字母及数字至少一个").css("color","red");
            } else {
                $('#warning2').html("通过").css("color","green");
            }
        }

        /**
         * 两次密码是否一致检查
         * 10/26/2017 PM
         */
        function checkPswsed() {
            var psw = $('#psw').val().trim();
            var pswsed = $('#pswsed').val().trim();
            if(psw == "") {
                $('#warning3').html("请先输入密码").css("color","red");
            } else if(pswsed != psw) {
                $('#warning3').html("两次输入的密码不一致").css("color","red");
            } else {
                $('#warning3').html("通过").css("color","green");
            }
        }

        /**
         * 注册按钮点击
         * 10/26/2017 PM
         */
        $('#confirm').on('click',function() {
            var data = checkInfo();

            if(data != "") {
                var url = "regist.do";
//                $.ajax({
//                    url:url,
//                    type:"post",
//                    data:data,
//                    dataType:"json",
//                    success:function(result) {
//                        if(result.state == 'SUCCESS'){
//                            alert("注册成功");
//                        } else {
//                            alert('注册失败');
//                        }
//                    }
//                });
                $.post(url,{data:JSON.stringify(data)},function(result) {
                    if(result.state == SUCCESS) {
                        alert("注册成功");
                    } else {
                        alert('注册失败: ' + result.message);
                        $('#reload').click();
                        $('#vertification').val("");
                        $('#warning4').html("请输入验证码").css("color","red");
                    }
                });
            }
        });

        /**
         * 注册信息验证
         * 10/30/2017
         * @returns {string} data
         */
        function checkInfo() {
            var userNameNode = $('#userName');
            var userName = $(userNameNode).val();
            var nickName = $('#nickName').val();
            var pswNode = $('#psw');
            var psw = $(pswNode).val();
            var pswsedNode = $('#pswsed');
            var confirm = $(pswsedNode).val();
            var vertificationNode = $('#vertification');
            var vertification = $(vertificationNode).val();
            var mailAddressNode = $('#mailAddress');
            var mailAddress = $(mailAddressNode).val();
            var data = "";

            if(userName == "") {
                $(userNameNode).focus();
                alert("请输入用户名");
                return data;
            }
            if(mailAddress == "") {
                $(mailAddressNode).focus();
                alert("请输入邮箱");
                return data;

            }
            if(psw == "") {
                $(pswNode).focus();
                alert("请输入密码");
                return data;
            }
            if(confirm == "") {
                $(pswsedNode).focus();
                alert("请输入确认密码");
                return data;
            }
            if(vertification == "") {
                $(vertificationNode).focus();
                alert("请输入验证码");
                return data;
            }
            if($('#warning1').html() == $('#warning2').html() && $('#warning3').html() == "通过" &&
                $('#warning4').html() == "通过" && $('#warning5').html() == "通过") {
                data = {
                    'userName': userName, 'password': psw, 'confirm': confirm, 'nickName': nickName,
                    'vertification': vertification, 'mailAddress': mailAddress
                };
                return data;
            } else {
                alert("注册信息填写有误");
                return data;
            }
        }

    </script>
</body>
</html>
