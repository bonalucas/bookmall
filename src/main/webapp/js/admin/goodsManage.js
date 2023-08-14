var activity = [];
var currentPage = 1;
// 页面加载完后执行
$(document).ready(function () {
    var path = $("#path").text();
    to_page(path, 1);
});

$(document).on("click",".description",function () {
    $(this).popover();
});

$(document).on("click",".templatemo-edit-btn",function () {
    // 单击编辑按钮弹出修改窗口
    $("#update-goods").modal({
        backdrop:'static'
    });
    //获取当前点击商品的数据
    var upGoodsid = $(this).parents("tr").find("td:eq(0)").text();
    var upGoodsname = $(this).parents("tr").find("td:eq(1)").text();
    var upGoodsPrice = $(this).parents("tr").find("td:eq(2)").text();
    var upGoodsNum = $(this).parents("tr").find("td:eq(3)").text();
    var upGoodsDetailCate = $(this).parents("tr").find("td:eq(4)").text();
    var upGoodsDes = $(this).parents("tr").find(".description").attr("data-content");
    // 回显到文本框中
    $("#goodsid").text(upGoodsid);
    $("#goodsname").val(upGoodsname);
    $("#price").val(upGoodsPrice);
    $("#num").val(upGoodsNum);
    $("#detailcate").val(upGoodsDetailCate);
    $("#description").val(upGoodsDes);
});

//修改商品信息
$(document).on("click","#saveUpdate",function () {
    // 获取修改后的商品信息
    var ugoodsid = $("#goodsid").text();
    var ugoodsname = $("#goodsname").val();
    var uprice = $("#price").val();
    var unum = $("#num").val();
    var udescription = $("#description").val();
    var ucategory = $("#category").val();
    var udetailcate = $("#detailcate").val();
    var path = $(this).val();
    $.ajax({
        url: path + "/admin/goods/update/",
        type:"POST",
        data:{
            goodsid:ugoodsid,
            goodsname:ugoodsname,
            price:uprice,
            num:unum,
            description:udescription,
            category:ucategory,
            detailcate:udetailcate,
        },
        success:function(result){
            // 隐藏窗口
            $("#update-goods").modal('hide');
            // 显示信息
            swal(result.msg,'','success');
            // 分页处理
            to_page(path,currentPage);
        },
        error:function(){
            alert("出现错误！！！");
        }
    });
});

$(document).on("click",".templatemo-delete-btn",function () {
    var goodsname = $(this).parents("tr").find("td:eq(1)").text();
    var goodsid = $(this).parents("tr").find("td:eq(0)").text();
    var path = $(this).val();
    swal({
            title: "确定删除" + goodsname + "吗？",
            type: "warning",
            showCancelButton: true,
            cancelButtonText:"取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确定删除！",
            closeOnConfirm: false,
        },
        function () {
            $.ajax({
                url: path + "/admin/goods/delete/" + goodsid,
                type: "DELETE",
                success:function (result) {
                    swal(result.msg, "","success");
                    to_page(path,currentPage);
                },
                error:function () {
                    to_page(path,currentPage);
                }
            });
        });
});

function showActInfo(activityId) {
    $('#activityname').text(activity[activityId-1].activityname);
    $('#activitydes').text(activity[activityId-1].activitydes);
    $('#discount').text(activity[activityId-1].discount);
    $('#fullprice').text(activity[activityId-1].fullprice);
    $('#reduceprice').text(activity[activityId-1].reduceprice);
    $('#fullnum').text(activity[activityId-1].fullnum);
    $('#reducenum').text(activity[activityId-1].reducenum);
}

// 选择栏发生变化时更新回显新数据
$("#activity-id").change(function () {
    showActInfo($(this).val());
});

function getActivity(path) {
    $.ajax({
        url: path + "/admin/activity/showjson",
        type: "post",
        success: function (result) {
            if(result.code === 100) {
                // 清空之前的标签
                $("#activity-id").empty();
                activity = result.info.activity;
                $.each(activity, function (index,item) {
                    $("#activity-id").append($("<option></option>").attr("value",item.activityid).append(item.activityid));
                });
                // 初始化时只需要获取第一个活动的数据回显即可
                showActInfo(1);
            } else {
                alert("获取活动信息失败！！！");
            }
        }
    });
}

//保存活动信息
$(document).on("click","#saveActivity",function () {
    var goodsid = $("#activity-goodsid").text();
    var activityid = $("#activity-id").val();
    var path = $(this).val();
    $.ajax({
        url:path + "/admin/activity/update/",
        type:"POST",
        data:{
            goodsid:goodsid,
            activityid:activityid
        },
        success:function(result){
            $("#activity-goods").modal('hide');
            swal(result.msg,'','success');
            to_page(path, currentPage);
        },
        error:function(){
            alert("出现错误！！！");
        }
    });
});

function to_page(path, page) {
    $.ajax({
        url: path + "/admin/goods/showjson",
        data: "page=" + page,
        type: "get",
        success: function (result) {
            //解析显示
            build_goods_table(path, result);
            //页面信息
            build_page_info(path, result);
            //分页
            build_page_nav(path, result);
            currentPage = page;
        }
    });
}

function build_goods_table(path,result) {
    // 清空之前的标签
    $("#goodsinfo tbody").empty();
    var goods = result.info.pageInfo.list;
    $.each(goods, function (index,item) {
        var goodsid = $("<td></td>").append(item.goodsid);
        var goodsname = $("<td></td>").append(item.goodsname);
        var price = $("<td></td>").append(item.price);
        var num = $("<td></td>").append(item.num);
        var detailcate = $("<td></td>").append(item.detailcate);
        var activityid = $("<td></td>").append(item.activityid);

        var detailBtn = $('<button type="button" class="description" data-container="body" data-toggle="popover" data-placement="top"></button>').append("描述");

        detailBtn = detailBtn.attr("data-content",item.description);

        var detailA = $("<a></a>").addClass("templatemo-link").attr("href",path + "/detail?goodsid="+item.goodsid).append("详情");

        var editBtn = $("<button></button>").addClass("templatemo-edit-btn").val(path).append("编辑");
        var deleteBtn = $("<button></button>").addClass("templatemo-delete-btn").val(path).append("删除");

        var desTd = $("<td></td>").append(detailBtn);

        //活动按钮
        var actBtn = $("<button></button>").addClass("templatemo-activity-btn").attr("data-actGoodsid",item.goodsid).val(path).append("添加");
        actBtn.click(function () {
            var path = $(this).val();
            $("#activity-goods").modal({
                backdrop:'static'
            });
            $("#activity-goodsid").text($(this).attr("data-actGoodsid"));
            getActivity(path);
        });

        var actTd = $("<td></td>").append(actBtn);

        var detailTd = $("<td></td>").append(detailA);
        var editTd = $("<td></td>").append(editBtn);
        var deleteTd = $("<td></td>").append(deleteBtn);

        // 回显数据
        $("<tr></tr>").append(goodsid).append(goodsname).append(price).append(num).append(detailcate).append(activityid).append(desTd).append(detailTd).append(editTd).append(deleteTd).append(actTd).appendTo("#goodsinfo tbody");
    })
}

function build_page_info(path,result) {
    // 清空之前的标签
    $("#page-info-area").empty();
    // 增加新的回显
    $("#page-info-area").append("当前第"+ result.info.pageInfo.pageNum +"页，总共"+ result.info.pageInfo.pages +"页，总共"+ result.info.pageInfo.total +"记录")
}

function build_page_nav(path,result) {
    // 清空之前的标签
    $("#page-div-nav ul").empty();
    var pageUl = $("<ul></ul>").addClass("pagination")

    // 首页标签
    var firstPage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"></span>")
            .append("首页")));

    var prePage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"><i class=\"fa fa-backward\"></i></span>")));

    // 判断是否存在上一页
    if(!result.info.pageInfo.hasPreviousPage) {
        prePage.addClass("li-none");
    } else {
        prePage.click(function () {
            to_page(path,result.info.pageInfo.prePage);
        });
    }

    //首页跳转
    firstPage.click(function () {
        to_page(path,1);
    });

    var nextPage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"><i class=\"fa fa-forward\"></i></span>")));

    var lastPage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"></span>")
            .append("末页")));

    // 判断是否有下一页
    if(!result.info.pageInfo.hasNextPage) {
        // 加入样式隐藏
        nextPage.addClass("li-none");
    } else {
        nextPage.click(function () {
            to_page(path,result.info.pageInfo.nextPage);
        });
    }

    // 末页跳转
    lastPage.click(function () {
        to_page(path,result.info.pageInfo.lastPage);
    });

    // 将首页末页加入ul标签中
    pageUl.append(firstPage).append(prePage);

    // 循环遍历输出对应数量的页数标签
    $.each(result.info.pageInfo.navigatepageNums,function (index,item) {
        var numLi = $("<li></li>").append($("<a></a>")
            .append($("<span aria-hidden=\"true\"></span>").append(item)));
        // 判断导航页码数是否和当前页数相等
        if(result.info.pageInfo.pageNum === item) {
            // 加入样式让其与别的不同
            numLi.addClass("active");
        }
        numLi.click(function () {
            to_page(path,item);
        });
        pageUl.append(numLi);
    });

    pageUl.append(nextPage).append(lastPage).appendTo("#page-div-nav");
}

