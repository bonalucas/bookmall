<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员登录</title>
    <link rel="icon" href="${pageContext.request.contextPath}/image/favicon.gif" type="image/x-icon"/>
    <link href="${pageContext.request.contextPath}/css/adminLogin/default.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/css/adminLogin/styles.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/css/adminLogin/demo.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/css/adminLogin/loaders.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class='login'>

    <div class='login_title'>
        <span>管理员登录</span>
    </div>
    <div class='login_fields'>
        <div class='login_fields__user'>
            <div class='icon'>
                <img alt="" src='${pageContext.request.contextPath}/image/adminLogin/user_icon_copy.png'>
            </div>
            <input name="adminname" id="username" placeholder='用户名' maxlength="16" class="username" type="text" autofocus autocomplete="off"/>
            <div class='validation'>
                <img alt="" src='${pageContext.request.contextPath}/image/adminLogin/tick.png'>
            </div>
        </div>
        <div class='login_fields__password'>
            <div class='icon'>
                <img alt="" src='${pageContext.request.contextPath}/image/adminLogin/lock_icon_copy.png'>
            </div>
            <input name="password" id="password" class="passwordNumder" placeholder='密码' maxlength="16" type="password" autocomplete="off">
            <div class='validation'>
                <img alt="" src='${pageContext.request.contextPath}/image/adminLogin/tick.png'>
            </div>
        </div>
        <div class='login_fields__submit'>
            <input type='button' id="loginBtn" value='登录'>
        </div>
    </div>
    <div class='success'>
    </div>
    <div class='disclaimer'>
        <p>欢迎进入Aba后台管理平台</p>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminLogin/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminLogin/jquery-ui.min.js"></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/adminLogin/stopExecutionOnTimeout.js?t=1'></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminLogin/layer-3.5.1/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminLogin/Particleground.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/adminLogin/jquery.mockjax.js"></script>
<script type="text/javascript">
    //粒子背景特效
    $('body').particleground({
        dotColor: '#E8DFE8',
        lineColor: '#1b3273'
    });

    $(document).ready(function (){
        alert("默认用户名：aba  密码：123456");
    })

    $('#loginBtn').click(function () {
        //用户名不能为空
        if($('#username').val().length === 0){
            alert('用户名不能为空');
            return;
        }
        //密码不能为空
        if($('#password').val().length === 0){
            alert('密码不能为空');
            return;
        }

        $('.login').addClass('test'); //倾斜特效
        setTimeout(function () {
            $('.login').addClass('testtwo'); //平移特效
        }, 300);

        var username=$('#username').val();
        var password=$('#password').val();
        var str = "?adminname="+username+"&password="+password;
        location.href="${pageContext.request.contextPath}/admin/confirmLogin"+str;
    });
</script>
</body>
<script>

</script>
</html>
