$(document).ready(function () {
    var path = $("#path").text();
    var currentPage = 1;
    to_page(path, 1);
});

$(document).on("click",".templatemo-delete-btn",function () {
    var username = $(this).parents("tr").find("td:eq(1)").text();
    var userid = $(this).parents("tr").find("td:eq(0)").text();
    var path = $(this).val();
    swal({
            title: "确定删除" + username + "吗？",
            type: "warning",
            showCancelButton: true,
            cancelButtonText:"取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确定删除！",
            closeOnConfirm: false,
        },
        function () {
            $.ajax({
                url: path + "/admin/user/delete/" + userid,
                type: "DELETE",
                success:function (result) {
                    swal(result.msg, "","success");
                    to_page(path,currentPage);
                }
            });
        });
});

function to_page(path, page) {
    $.ajax({
        url: path + "/admin/user/showjson",
        data: "page=" + page,
        type: "get",
        success: function (result) {
            //解析显示
            build_user_table(path, result);
            //页面信息
            build_page_info(path, result);
            //分页
            build_page_nav(path, result);

            currentPage = page;
        }
    });
}

function build_user_table(path,result) {
    // 清除上一次查询的标签
    $("#goodsinfo tbody").empty();
    var goods = result.info.pageInfo.list;
    $.each(goods, function (index,item) {
        var userid = $("<td></td>").append(item.userid);
        var username = $("<td></td>").append(item.username);
        var email = $("<td></td>").append(item.email);
        var telephone = $("<td></td>").append(item.telephone);
        // val(path)加入一个服务器上下文url
        var deleteBtn = $("<button></button>").addClass("templatemo-delete-btn").val(path).append("删除");

        var deleteTd = $("<td></td>").append(deleteBtn);

        // 将每个标签加入tbody中
        $("<tr></tr>").append(userid)
            .append(username)
            .append(email)
            .append(telephone)
            .append(deleteTd).appendTo("#goodsinfo tbody");
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
        // 加入样式进行隐藏
        prePage.addClass("li-none");
    } else {
        prePage.click(function () {
            to_page(path, result.info.pageInfo.prePage);
        });
    }

    // 首页跳转
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
        // 将分页个数加入ul标签
        pageUl.append(numLi);
    });

    // 将上一页和下一页箭头加入ul标签
    pageUl.append(nextPage).append(lastPage).appendTo("#page-div-nav");
}

// 下面代码是分页在JSP，转换成上面的jquery显示
// <ul class="pagination">
//     <li>
//         <a href="${pageContext.request.contextPath}/admin/goods/show?page=1" aria-label="Next">
//             <span aria-hidden="true">首页</span>
//         </a>
//     </li>
//
//     <c:if test="${pageInfo.hasPreviousPage}">
//         <li>
//             <a href="${pageContext.request.contextPath}/admin/goods/show?page=${pageInfo.pageNum - 1}" aria-label="Previous">
//                 <span aria-hidden="true"><i class="fa fa-backward"></i></span>
//             </a>
//         </li>
//     </c:if>
//
//     <c:forEach items="${pageInfo.navigatepageNums}" var="pageNums">
//         <c:if test="${pageNums == pageInfo.pageNum}">
//             <li class="active"><a href="${pageContext.request.contextPath}/admin/goods/show?page=${pageNums}">${pageNums}</a></li>
//         </c:if>
//         <c:if test="${pageNums != pageInfo.pageNum}">
//             <li><a href="${pageContext.request.contextPath}/admin/goods/show?page=${pageNums}">${pageNums}</a></li>
//         </c:if>
//     </c:forEach>
//
//     <c:if test="${pageInfo.hasNextPage}">
//         <li>
//             <a href="${pageContext.request.contextPath}/admin/goods/show?page=${pageInfo.pageNum + 1}" aria-label="Next">
//                 <span aria-hidden="true"><i class="fa fa-forward"></i></span>
//             </a>
//         </li>
//     </c:if>
//     <li>
//         <a href="${pageContext.request.contextPath}/admin/goods/show?page=${pageInfo.pages}" aria-label="Next">
//             <span aria-hidden="true">末页</span>
//         </a>
//     </li>
// </ul>