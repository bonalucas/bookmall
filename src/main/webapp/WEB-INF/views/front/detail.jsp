<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aba-${goodsInfo['goods'].goodsname}</title>
    <link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/image/favicon.gif">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shopdetail.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/front/sort.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/detail.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // 获取上下文路径
            var path = $("#path").text();
            var showproduct = {
                "boxid": "showbox",
                "sumid": "showsum",
                "boxw": 400,
                "boxh": 550,
                "sumw": 60, //列表每个宽度,该版本中请把宽高填写成一样
                "sumh": 60, //列表每个高度,该版本中请把宽高填写成一样
                "sumi": 7, //列表间隔
                "sums": 5, //列表显示个数
                "sumsel": "sel",
                "sumborder": 1, //列表边框，没有边框填写0，边框在css中修改
                "lastid": "showlast",
                "nextid": "shownext"
            };
            //方法调用detail.js
            $.ljsGlasses.pcGlasses(showproduct);

            $(function () {
                $('.tabs a').click(function () {
                    var $this = $(this);
                    $('.panel').hide();
                    $('.tabs a.active').removeClass('active');
                    $this.addClass('active').blur();
                    var panel = $this.attr("href");
                    $(panel).show();
                    return fasle;
                });
                $(".tabs li:first a").click();
            });

            $(".centerbox li").click(function () {
                $("li").removeClass("now");
                $(this).addClass("now");
            });

            $('.fav-button').click(function(){
                var goodsId = $(this).attr('data-id');
                var isChangeBtn = true;
                if(!$(this).children("i").hasClass('fa-heart')) {
                    //收藏
                    $.ajax({
                        url:path + "/collect",
                        type:"POST",
                        data:{
                            goodsid:goodsId
                        },
                        success:function (result) {
                            if(result.code === 200){
                                location.href = path + "/login";
                                isChangeBtn = false;
                            }else{
                                alert("收藏成功！");
                            }
                        },
                        error:function () {
                            alert("收藏失败！");
                        }
                    })
                } else {
                    //取消收藏
                    $.ajax({
                        url:path + "/deleteCollect",
                        type:"POST",
                        data:{
                            goodsid:goodsId
                        },
                        success:function (result) {
                            //取消收藏成功
                            if(result.code === 200){
                                location.href = path + "/login";
                                isChangeBtn = false;
                            }else{
                                alert("取消收藏成功！")
                            }
                        },
                        error:function () {
                            alert("取消收藏失败！");
                        }
                    })
                }
                if(isChangeBtn) {
                    $(this).children("i").toggleClass("fa-heart fa-heart-o");
                    var likeContent = $(this).children("span").text();
                    if(likeContent === '收藏'){
                        $(this).children("span").text('取消收藏');
                    } else {
                        $(this).children("span").text('收藏');
                    }
                }
            });
        });
    </script>
    <style>
        .head{
            width: 45px !important;
            background: rgba(0,0,0,.0001) none repeat scroll 0 0 !important;
            border: 1px solid rgba(0,0,0,.075) !important;
        }
        .span-block{
            display: block !important;
            padding:5px;
        }
    </style>
</head>
<body>
<div class="elavator_area">
    <div class="container">
        <jsp:include page="header.jsp"/>
        <div class="shop_menu shop_menu_2 main-detail-div">
            <ul class="cramb_area cramb_area_5 main-detail-nav">
                <li><a href="${pageContext.request.contextPath}/main">首页 /</a></li>
                <li class="br-active">${goodsInfo['goods'].goodsname}</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                <div class="shopdetails">
                    <div id="leftbox">
                        <div id="showbox">
                            <c:forEach items="${goodsInfo['image']}" var="i">
                                <img src="${pageContext.request.contextPath}/shopImage/${i.path}" width="400" height="400"/>
                            </c:forEach>
                        </div>
                        <div id="showsum">
                        </div>
                        <p class="showpage">
                            <a href="javascript:void(0);" id="showlast"> < </a>
                            <a href="javascript:void(0);" id="shownext"> > </a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                <div class="elav_titel">
                    <div class="elv_heading">
                        <h3>${goodsInfo['goods'].goodsname}</h3>
                    </div>
                    <div class="price_rating">
                    </div>
                </div>
                <div class="elav_info">
                    <div class="price_box price_box_acr new_meta">
                        <span class="spical-price spical-price-2">￥${goodsInfo['goods'].price}</span>
                    </div>
                    <div class="new_meta">
                            <span class="sku_wrapper big-font">
                                类别:
                                <span class="sku">${goodsInfo['cate'].catename}</span>
                            </span>
                        <span class="sku_wrapper big-font">
                                数量:
                                <span class="sku">${goodsInfo['goods'].num}</span>
                            </span>
                    </div>
                    <div class="new_meta">
                            <span class="sku_wrapper big-font">
                                优惠:
                                <c:if test="${goodsInfo['goods'].activityid != 1}">
                                    <span class="sku">${goodsInfo['goods'].activity.activityname}</span>
                                    <span class="span-block">${goodsInfo['goods'].activity.activitydes}</span>
                                    <span class="span-block">折扣:${goodsInfo['goods'].activity.discount}</span>
                                    <c:if test="${!empty goodsInfo['goods'].activity.fullprice}">
                                        <span class="span-block">
                                            满${goodsInfo['goods'].activity.fullprice}减${goodsInfo['goods'].activity.reduceprice}
                                        </span>
                                    </c:if>
                                    <c:if test="${!empty goodsInfo['goods'].activity.fullnum}">
                                        <span class="span-block">
                                            满${goodsInfo['goods'].activity.fullnum}免${goodsInfo['goods'].activity.reducenum}
                                        </span>
                                    </c:if>
                                </c:if>
                                <c:if test="${goodsInfo['goods'].activityid == 1}">
                                    <span class="sku">暂无优惠，敬请期待！</span>
                                </c:if>
                            </span>
                    </div>
                    <div class="rel-div">
                        <div class="add_defi new_meta">
                            <a id="chatto" href="" data-original-title="Add to Wishlist" data-toggle="tooltip" class=" big-font">
                                <i class="fa fa-commenting"></i>
                                联系客服
                            </a>
                        </div>
                        <form class="cart-btn-area new_meta" action="${pageContext.request.contextPath}/addCart" method="post">
                            <input type="hidden" value="${goodsInfo['goods'].goodsid}" name="goodsid"/>
                            <input type="number" value="1" name="goodsnum">
                            <button class="add-tocart cart_zpf" type="submit">加入购物车</button>
                        </form>
                        <div class="add_defi new_meta">
                            <a data-original-title="Add to Wishlist" data-toggle="tooltip" class="fav-button big-font" data-id="${goodsInfo['goods'].goodsid}">
                                <c:if test="${goodsInfo['goods'].fav}">
                                    <i class="fa fa-heart"></i>
                                    取消收藏
                                </c:if>
                                <c:if test="${!goodsInfo['goods'].fav}">
                                    <i class="fa fa-heart-o"></i>
                                    <span class="like-content">收藏</span>
                                </c:if>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="tab_area_start">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12 text-right">
                <div class="my-tabs">
                    <ul class="favtabs favtabs-2 favtabs-nytr" role="tablist">
                        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab"
                                                                  data-toggle="tab">商品描述</a></li>
                        <li role="presentation">
                            <a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">评价
                            (${commentList.size()})</a></li>
                    </ul>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="home">
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="tb_desc">
                                        <h2>商品描述</h2>
                                        <p>${goodsInfo['goods'].description}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="profile">
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="tb_desc">
                                        <div class="review_area_heading">
                                            <div id="comnt">
                                                <h2>${commentList.size()}条评论</h2>
                                                <ol class="commentlist">
                                                    <c:forEach items="${commentList}" var="comment">
                                                        <li id="li-comment-22" class="comment even thread-even depth-1"
                                                            itemscope="">
                                                            <div id="comment-22" class="comment_container">
                                                                <img class="head avatar avatar-60 photo " width="60" height="60"
                                                                     src="${pageContext.request.contextPath}/image/favicon.gif" alt="">
                                                                <div class="comment-text">
                                                                    <div class="star-rating" title="Rated ${comment.point} out of 5"
                                                                         itemscope="">
                                                                        <div class="price_rating price_rating_2">
                                                                          <c:forEach  begin="1" end="${comment.point}">
                                                                              <a href="">
                                                                                  <i class="fa fa-star"></i>
                                                                              </a>
                                                                          </c:forEach>
                                                                            <c:forEach begin="${comment.point+1}" end="5">
                                                                                <a class="not-rated" href="">
                                                                                    <i class="fa fa-star-o"
                                                                                       aria-hidden="true"></i>
                                                                                </a>
                                                                            </c:forEach>
                                                                            <span>
                                                                                <strong>${comment.point}</strong>
                                                                                out of ${5-comment.point}
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                    <p class="meta">
                                                                        <strong>${comment.username}</strong>
                                                                        –
                                                                        <time datetime="${comment.commenttime}">
                                                                            ${comment.commenttime.year+1900}年
                                                                            ${comment.commenttime.month+1}月
                                                                            ${comment.commenttime.date}日
                                                                        </time>
                                                                        :
                                                                        <a  href="${pageContext.request.contextPath}/chat?sendto=${comment.userid}" data-original-title="Add to Wishlist" data-toggle="tooltip" class=" big-font">
                                                                            <i class="fa fa-commenting"></i>
                                                                        </a>
                                                                    </p>
                                                                    <div class="description">
                                                                        <p>${comment.content}</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ol>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 传递上下文路径给js使用 -->
<div id="path" style="display: none;">${pageContext.request.contextPath}</div>
</body>
</html>


