<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="A front-end template that helps you build fast, modern mobile web apps.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <title>个人信息</title>
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Material Design Lite">
    <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
    <meta name="msapplication-TileColor" content="#3372DF">
    <link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/image/favicon.gif">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/image/favicon.gif">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/image/favicon.gif">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-light_blue.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/infostyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sweetalert.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/front/information.js"></script>
    <style>
        .templatemo-blue-button {
            background-color: #39ADB4;
            border: none;
            color: white;
        }
    </style>
</head>
<body>

<!-- 修改用户信息模块  -->
<div class="modal fade" id="update-info" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改个人信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="update-form" name="update-form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="name" id="name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email" id="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="telephone" class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="telephone" name="telephone">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveInfo" value="${pageContext.request.contextPath}">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改密码模块 -->
<div class="modal fade" id="update-Psw" tabindex="-1" role="dialog" aria-labelledby="myModalLabelPsw">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabelPsw">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updatePsw-form" name="update-form" method="post">
                    <div class="form-group">
                        <label for="oldPsw" class="col-sm-2 control-label">旧密码</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" name="oldPsw" id="oldPsw">
                        </div>
                    </div>
                    <div class="form-group" style="display: none" id="oldPswError">
                        <label for="name" class="col-sm-2 control-label"></label>
                        <div class="col-sm-9">
                            <label style="color: #BD1F3B">密码错误</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="newPsw" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" name="newPsw" id="newPsw">
                        </div>
                    </div>
                    <div class="form-group" style="display: none" id="newPswError">
                        <label for="name" class="col-sm-2 control-label"></label>
                        <div class="col-sm-9">
                            <label style="color: #BD1F3B">密码应长度大于6</label>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="savePsw" value="${pageContext.request.contextPath}">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header">
    <header class="demo-header mdl-layout__header mdl-color--grey-100 mdl-color-text--grey-600">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">个人信息</span>
            <div class="mdl-layout-spacer"></div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable">
            </div>
        </div>
    </header>
    <div class="demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50">
        <header class="demo-drawer-header">
            <div class="demo-avatar-dropdown">
                <h1>Aba</h1>
                <div class="mdl-layout-spacer">
                </div>
            </div>
        </header>
        <nav class="demo-navigation mdl-navigation mdl-color--blue-grey-800">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/main"><i class="mdl-color-text--blue-grey-400 material-icons" role="presentation">home</i>主页</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/information"><i class="mdl-color-text--blue-grey-400 material-icons" role="presentation">inbox</i>个人信息</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/info/list"><i class="mdl-color-text--blue-grey-400 material-icons" role="presentation">forum</i>订单管理</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/info/address"><i class="mdl-color-text--blue-grey-400 material-icons" role="presentation">local_offer</i>地址管理</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/info/favorite"><i class="mdl-color-text--blue-grey-400 material-icons" role="presentation">flag</i>我的收藏</a>
        </nav>
    </div>
    <main class="mdl-layout__content mdl-color--grey-100">
        <div class="mdl-grid demo-content">
            <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
                <div class="tab-content">
                        <table class="table" cellpadding="6" cellspacing="1">
                            <thead>
                            <th style="border: 0px solid transparent">
                            </th>
                            </thead>
                            <tbody>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">用户号</th>
                                <td style="border: 0px solid transparent" class="tr" id="userIdVal">${user.userid}</td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">用户名</th>
                                <td style="border: 0px solid transparent" class="tr" id="nameVal">${user.username}</td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">注册时间</th>
                                <td style="border: 0px solid transparent" class="tr" id="regTimeVal">
                                    ${user.regtime.year+1900} 年
                                    ${user.regtime.month+1} 月
                                    ${user.regtime.date} 日
                                </td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">邮箱</th>
                                <td style="border: 0px solid transparent" class="tr" id="emailVal">${user.email}</td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">手机号</th>
                                <td style="border: 0px solid transparent" class="tr" id="telephoneVal">${user.telephone}</td>
                            </tr>
                            <i Psw="${user.password}" id="Psw"></i>
                            </tbody>
                        </table>
                    </div>
                <div class="mdl-card__actions mdl-card--border">
                    <button class="templatemo-blue-button" id="changeInfo"><h5>修改信息</h5></button>
                    <button class="templatemo-blue-button" id="changePsw"><h5>修改密码</h5></button>
                </div>
            </div>
        </div>
    </main>
</div>
<script type="text/javascript" src="https://code.getmdl.io/1.3.0/material.min.js"></script>
</body>
</html>
