<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Aba二手书城商城</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
    <link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/image/favicon.gif">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/holder.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/front/sort.js"></script>
</head>
<body>
<div id="main" class="container">
    <div id="header">
        <%@ include file="header.jsp" %>
        <!-- 旋转图 -->
        <div class="header-bottom">
            <div class="sort">
                <div class="sort-channel">
                    <ul class="sort-channel-list list-group">
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/category?cate=文学">文学</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/category?cate=经济">经济</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/category?cate=艺术">艺术</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/category?cate=数理科学">数理科学</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/category?cate=计算机科学">计算机科学</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/category?cate=工业技术">工业技术</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/category?cate=综合性图书">综合性图书</a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 轮播图 -->
            <div id="mycarousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="${pageContext.request.contextPath}/image/banner1.jpg" alt="">
                    </div>

                    <div class="item">
                        <img src="${pageContext.request.contextPath}/image/banner2.jpg" alt="">
                    </div>
                    <div class="item">
                        <img src="${pageContext.request.contextPath}/image/banner3.jpg" alt="">
                    </div>
                    <div class="item">
                        <img src="${pageContext.request.contextPath}/image/banner4.jpg" alt="">
                    </div>
                </div>

                <ol class="carousel-indicators">
                    <li data-target="#mycarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#mycarousel" data-slide-to="1"></li>
                    <li data-target="#mycarousel" data-slide-to="2"></li>
                    <li data-target="#mycarousel" data-slide-to="3"></li>
                </ol>

                <a class="left carousel-control" href="#mycarousel" role="button"
                   data-slide="prev" style="display: none;">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#mycarousel" role="button"
                        data-slide="next" style="display: none;">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <div class="clear-float"></div>
        </div>
    </div>
    <div class="content">
        <c:if test="${!empty ltGoods}">
            <div class="module">
                <div class="hd">
                    <h2>文学</h2>
                    <hr>
                </div>
                <div class="bd">
                    <div class="data">
                        <ul>
                            <c:forEach items="${ltGoods}" var="goods">
                                <li class="data-item-li">
                                    <div class="to-big">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">
                                            <img src="${pageContext.request.contextPath}/shopImage/${goods.imagePaths[0].path}" alt=""
                                                 width="200" height="200"/>
                                        </a>
                                    </div>
                                    <p class="text-right">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                    </p>
                                    <div class="text-right">
                                        <b>￥${goods.price}</b>
                                    </div>
                                    <div>
                                        <!-- 判断是否可收藏或已收藏 -->
                                        <c:if test="${goods.fav}">
                                            <button class="like-button glyphicon glyphicon-heart btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;">
                                            </button>
                                        </c:if>
                                        <c:if test="${!goods.fav}">
                                            <button class="like-button glyphicon glyphicon-heart-empty btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;">
                                            </button>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                            <div class="clear-float" style="clear: both;"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${!empty emGoods}">
            <div class="module">
                <div class="hd">
                    <h2>经济</h2>
                    <hr>
                </div>
                <div class="bd">
                    <div class="data">
                        <ul>
                            <c:forEach items="${emGoods}" var="goods">
                                <li class="data-item-li">
                                    <div class="to-big">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">
                                            <img src="${pageContext.request.contextPath}/shopImage/${goods.imagePaths[0].path}" alt=""
                                                 width="200" height="200"/>
                                        </a>
                                    </div>
                                    <p class="text-right">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                    </p>
                                    <div class="text-right">
                                        <b>￥${goods.price}</b>
                                    </div>
                                    <div>
                                        <!-- 判断是否可收藏或已收藏 -->
                                        <c:if test="${goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                        <c:if test="${!goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart-empty btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                            <div class="clear-float" style="clear: both;"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${!empty artGoods}">
            <div class="module">
                <div class="hd">
                    <h2>艺术</h2>
                    <hr>
                </div>
                <div class="bd">
                    <div class="data">
                        <ul>
                            <c:forEach items="${artGoods}" var="goods">
                                <li class="data-item-li">
                                    <div class="to-big">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">
                                            <img src="${pageContext.request.contextPath}/shopImage/${goods.imagePaths[0].path}" alt=""
                                                 width="200" height="200"/>
                                        </a>
                                    </div>
                                    <p class="text-right">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                    </p>
                                    <div class="text-right">
                                        <b>￥${goods.price}</b>
                                    </div>
                                    <div>
                                        <!-- 判断是否可收藏或已收藏 -->
                                        <c:if test="${goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                        <c:if test="${!goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart-empty btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                            <div class="clear-float" style="clear: both;"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${!empty msGoods}">
            <div class="module">
                <div class="hd">
                    <h2>数理科学</h2>
                    <hr>
                </div>
                <div class="bd">
                    <div class="data">
                        <ul>
                            <c:forEach items="${msGoods}" var="goods">
                                <li class="data-item-li">
                                    <div class="to-big">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">
                                            <img src="${pageContext.request.contextPath}/shopImage/${goods.imagePaths[0].path}" alt=""
                                                 width="200" height="200"/>
                                        </a>
                                    </div>
                                    <p class="text-right">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                    </p>
                                    <div class="text-right">
                                        <b>￥${goods.price}</b>
                                    </div>
                                    <div>
                                        <!-- 判断是否可收藏或已收藏 -->
                                        <c:if test="${goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                        <c:if test="${!goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart-empty btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                            <div class="clear-float" style="clear: both;"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${!empty csGoods}">
            <div class="module">
                <div class="hd">
                    <h2>计算机科学</h2>
                    <hr>
                </div>
                <div class="bd">
                    <div class="data">
                        <ul>
                            <c:forEach items="${csGoods}" var="goods">
                                <li class="data-item-li">
                                    <div class="to-big">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">
                                            <img src="${pageContext.request.contextPath}/shopImage/${goods.imagePaths[0].path}" alt=""
                                                 width="200" height="200"/>
                                        </a>
                                    </div>
                                    <p class="text-right">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                    </p>
                                    <div class="text-right">
                                        <b>￥${goods.price}</b>
                                    </div>
                                    <div>
                                        <!-- 判断是否可收藏或已收藏 -->
                                        <c:if test="${goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                        <c:if test="${!goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart-empty btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                            <div class="clear-float" style="clear: both;"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${!empty itGoods}">
            <div class="module">
                <div class="hd">
                    <h2>工业技术</h2>
                    <hr>
                </div>
                <div class="bd">
                    <div class="data">
                        <ul>
                            <c:forEach items="${itGoods}" var="goods">
                                <li class="data-item-li">
                                    <div class="to-big">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">
                                            <img src="${pageContext.request.contextPath}/shopImage/${goods.imagePaths[0].path}" alt=""
                                                 width="200" height="200"/>
                                        </a>
                                    </div>
                                    <p class="text-right">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                    </p>
                                    <div class="text-right">
                                        <b>￥${goods.price}</b>
                                    </div>
                                    <div>
                                        <!-- 判断是否可收藏或已收藏 -->
                                        <c:if test="${goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                        <c:if test="${!goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart-empty btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                            <div class="clear-float" style="clear: both;"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${!empty othGoods}">
            <div class="module">
                <div class="hd">
                    <h2>综合性图书</h2>
                    <hr>
                </div>
                <div class="bd">
                    <div class="data">
                        <ul>
                            <c:forEach items="${othGoods}" var="goods">
                                <li class="data-item-li">
                                    <div class="to-big">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">
                                            <img src="${pageContext.request.contextPath}/shopImage/${goods.imagePaths[0].path}" alt=""
                                                 width="200" height="200"/>
                                        </a>
                                    </div>
                                    <p class="text-right">
                                        <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                    </p>
                                    <div class="text-right">
                                        <b>￥${goods.price}</b>
                                    </div>
                                    <div>
                                        <!-- 判断是否可收藏或已收藏 -->
                                        <c:if test="${goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                        <c:if test="${!goods.fav}">
                                            <button
                                                    class="like-button glyphicon glyphicon-heart-empty btn btn-default"
                                                    data-id="${goods.goodsid}"
                                                    style="display: none;"></button>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                            <div class="clear-float" style="clear: both;"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    <!-- 传递上下文路径给js使用 -->
    <div id="path" style="display: none;">${pageContext.request.contextPath}</div>
</div>
</body>
</html>


