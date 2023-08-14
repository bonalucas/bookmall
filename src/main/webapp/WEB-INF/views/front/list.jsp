<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="A front-end template that helps you build fast, modern mobile web apps.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Material Design Lite">
    <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
    <meta name="msapplication-TileColor" content="#3372DF">
    <title>个人信息-我的订单</title>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/distpicker.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.raty.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/front/list.js"></script>
    <style>
        .templatemo-blue-button {
            background-color: #39ADB4;
            border: none;
            color: white;
        }
        .no-border{border: 0px solid transparent !important;}
        .finish-btn{
            background-color:#e65b0e !important;
        }
        .font-color{
            color: #00BBD6; !important;
        }
    </style>
</head>
<body>
<!-- 商品评论窗口模块 -->
<div class="modal fade" id="evaluate" tabindex="-1" role="dialog" aria-labelledby="myModalLabelPsw">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabelPsw">商品评价</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updatePsw-form" name="update-form" method="post">
                    <div class="form-group">
                        <label for="star" class="col-sm-2 control-label">商品评分</label>
                        <div class="col-sm-9">
                            <div id="star" data-num="3.5"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-sm-2 control-label">详细描述</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" rows="3" id="description"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveEvaluate" value="${pageContext.request.contextPath}">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header">
    <header class="demo-header mdl-layout__header mdl-color--grey-100 mdl-color-text--grey-600">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">订单管理</span>
            <div class="mdl-layout-spacer"></div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable">
            </div>
        </div>
    </header>
    <div class="demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50">
        <header class="demo-drawer-header">
            <div class="demo-avatar-dropdown">
                <h1>Aba</h1>
                <div class="mdl-layout-spacer"></div>
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
            <div class="mdl-grid demo-content" id="parent">
                <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
                    <h3>未发货</h3>
                    <c:forEach items="${orderList}" var="order">
                        <!-- 判断当前商品是否发货 -->
                        <c:if test="${!order.issend}">
                            <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid" name="parent">
                            <div class="tab-content col-lg-12">
                                <table class="table " cellpadding="6" cellspacing="1" >
                                    <tbody>
                                    <td class="no-border col-lg-9" >
                                        订单号：<i name="orderid">${order.orderid}</i>
                                        &nbsp;
                                        &nbsp;
                                        订单日期:
                                            ${order.ordertime.year+1900} 年
                                            ${order.ordertime.month+1} 月
                                            ${order.ordertime.date} 日
                                        &nbsp;
                                        收货地址:
                                            ${order.address.province}
                                            ${order.address.city}
                                            ${order.address.county}
                                    </td>
                                    <td  class="no-border col-lg-3">
                                        原价:${order.oldprice}  现价:${order.newprice}
                                    </td>
                                    </tbody>
                                </table>
                                <table class="table " cellpadding="6" cellspacing="1">
                                    <tbody>
                                    <tr>
                                        <td class="col-lg-1">
                                            商品号
                                        </td>
                                        <td class="col-lg-2">
                                            商品名称
                                        </td>
                                        <td class="col-lg-1">
                                            价格
                                        </td>
                                        <td class="col-lg-1">
                                            数量
                                        </td>
                                        <td class="col-lg-2">
                                            商品分类
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            <c:forEach items="${order.goodsInfo}" var="good">
                                    <table class="table table-bordered" cellpadding="6" cellspacing="1" >
                                        <tbody>
                                        <tr>
                                            <td class="col-lg-1">
                                                    ${good.goodsid}
                                            </td>
                                            <td class="col-lg-2">
                                                <a href="${pageContext.request.contextPath}/detail?goodsid=${good.goodsid}">${good.goodsname}</a>
                                            </td>
                                            <td class="col-lg-1">
                                                    ${good.price}
                                            </td>
                                            <td class="col-lg-1">
                                                    ${good.num}
                                            </td>
                                            <td class="col-lg-2">
                                                    ${good.category}
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                            </c:forEach>
                            </div>
                            <div class="mdl-card__actions mdl-card--border">
                            </div>
                        </div>
                        </c:if>
                    </c:forEach>
                </div>

                <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
                    <h3>未收货</h3>
                    <c:forEach items="${orderList}" var="order">
                        <!-- 判断当前商品是否发货和未收货 -->
                        <c:if test="${order.issend&&!order.isreceive}">
                            <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid" name="parent">
                                <div class="tab-content col-lg-12">
                                    <table class="table " cellpadding="6" cellspacing="1" >
                                        <tbody>
                                        <tr>
                                            <td class="no-border col-lg-9" >
                                                订单号：<i name="orderid">${order.orderid}</i>
                                                &nbsp;
                                                订单日期:
                                                    ${order.ordertime.year+1900} 年
                                                    ${order.ordertime.month+1} 月
                                                    ${order.ordertime.date} 日
                                                &nbsp;
                                                收货地址:
                                                    ${order.address.province}
                                                    ${order.address.city}
                                                    ${order.address.county}
                                            </td>
                                            <td  class="no-border col-lg-3">
                                                原价:${order.oldprice}  现价:${order.newprice}
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table class="table " cellpadding="6" cellspacing="1" >
                                        <tbody>
                                        <tr>
                                            <td class="col-lg-1">
                                                商品号
                                            </td>
                                            <td class="col-lg-2">
                                                商品名称
                                            </td>
                                            <td class="col-lg-1">
                                                价格
                                            </td>
                                            <td class="col-lg-1">
                                                数量
                                            </td>
                                            <td class="col-lg-2">
                                                商品分类
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <c:forEach items="${order.goodsInfo}" var="good">
                                    <table class="table table-bordered" cellpadding="6" cellspacing="1" >
                                        <tbody>
                                        <tr>
                                            <td class="col-lg-1">
                                                    ${good.goodsid}
                                            </td>
                                            <td class="col-lg-2">
                                                <a href="${pageContext.request.contextPath}/detail?goodsid=${good.goodsid}">${good.goodsname}</a>
                                            </td>
                                            <td class="col-lg-1">
                                                    ${good.price}
                                            </td>
                                            <td class="col-lg-1">
                                                    ${good.num}
                                            </td>
                                            <td class="col-lg-2">
                                                    ${good.category}
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    </c:forEach>
                                </div>
                                <div class="mdl-card__actions mdl-card--border">
                                    <button class="templatemo-blue-button " name="finishList" value="${pageContext.request.contextPath}"><h5>完成订单</h5></button>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                </div>
                <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
                    <h3>已完成</h3>
                    <c:forEach items="${orderList}" var="order">
                        <!-- 判断当前商品是否已完成 -->
                        <c:if test="${order.iscomplete}">
                            <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid" name="parent">
                                <div class="tab-content col-lg-12">
                                    <table class="table " cellpadding="6" cellspacing="1" >
                                        <tbody>
                                        <tr>
                                            <td class="no-border col-lg-9" >
                                                订单号：<i name="orderid">${order.orderid}</i>
                                                &nbsp;
                                                &nbsp;
                                                订单日期:
                                                    ${order.ordertime.year+1900} 年
                                                    ${order.ordertime.month+1} 月
                                                    ${order.ordertime.date} 日
                                                &nbsp;
                                                收货地址:
                                                    ${order.address.province}
                                                    ${order.address.city}
                                                    ${order.address.county}
                                            </td>
                                            <td  class="no-border col-lg-3">
                                               原价:${order.oldprice}  现价:${order.newprice}
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table class="table " cellpadding="6" cellspacing="1" >
                                        <tbody>
                                        <tr>
                                            <td class="col-lg-1">
                                                商品号
                                            </td>
                                            <td class="col-lg-2">
                                                商品名称
                                            </td>
                                            <td class="col-lg-1">
                                                价格
                                            </td>
                                            <td class="col-lg-1">
                                                数量
                                            </td>
                                            <td class="col-lg-2">
                                                商品分类
                                            </td>
                                            <td class="col-lg-1">

                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <c:forEach items="${order.goodsInfo}" var="good">
                                    <table class="table table-bordered" cellpadding="6" cellspacing="1">
                                        <tbody>
                                        <tr>
                                            <td class="col-lg-1">
                                                    ${good.goodsid}
                                            </td>
                                            <td class="col-lg-2">
                                                <a href="${pageContext.request.contextPath}/detail?goodsid=${good.goodsid}">${good.goodsname}</a>
                                            </td>
                                            <td class="col-lg-1">
                                                    ${good.price}
                                            </td>
                                            <td class="col-lg-1">
                                                    ${good.num}
                                            </td>
                                            <td class="col-lg-2">
                                                    ${good.category}
                                            </td>
                                            <td class="col-lg-1">
                                                <button class="mdl-button mdl-js-button mdl-js-ripple-effect font-color" name="evaluate" ><h5>评价</h5></button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    </c:forEach>
                                </div>
                                <div class="mdl-card__actions mdl-card--border">
                                    <button class="templatemo-blue-button finish-btn" name="deleteList" value="${pageContext.request.contextPath}"><h5>删除订单</h5></button>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
    </main>
</div>

<script type="text/javascript" src="https://code.getmdl.io/1.3.0/material.min.js"></script>
</body>
</html>
