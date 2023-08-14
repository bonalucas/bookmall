$(document).ready(function () {
    var path = $("#path").text();
    showcart(path);
});

function deleteCartGoods(goodsid,path) {
    $.ajax({
        url: path + "/deleteCart/" + goodsid,
        type: "DELETE",
        success: function (result) {
            showcart(path);
        },
        error:function () {
            swal("删除失败");
        }
    })
}

//改变商品数量更新购物车
function updateCart(goodsid, newNum, path) {
    // 放置负值
    if (newNum <= 0){
        newNum = 1;
    }
    $.ajax({
        url: path + "/update",
        data: {
            goodsid: goodsid,
            num:newNum
        },
        method: "post",
        success: function (result) {
            showcart(path);
        },
        error: function (result) {
            swal("更新购物车失败");
        }
    });
}

function showcart(path) {
    $.ajax({
        url: path + "/cartjson",
        type: "post",
        success: function (result) {
            //显示购物车
            build_cart_table(result,path);
        },
        error: function (result) {
            swal("获取购物车失败");
        }
    });
}

function build_cart_table(result,path) {
    $("#cart-table tbody").empty();
    var goods = result.info.shopcart;
    var totalnum = 0;
    var totalMoney = 0;
    if(goods.length === 0) {
        var spareTd = $('<tr> <td colspan="6"> <div class="coupon" style="margin-left:37%;">购物车还是空的，快去<a href="/bookmall/main" style="color:red;">首页</a>看看吧！ </div> </td> </tr>');
        spareTd.appendTo("#cart-table tbody");
    } else {
        $.each(goods, function (index,item) {
            var delA = $("<button></button>").addClass("delete-goods").attr("data-goodsid",item.goodsid).append("删除");
            var deleteCart = $("<td></td>").addClass("product-remove product-remove_2")
                .append(delA);
            delA.click(function () {
                deleteCartGoods(item.goodsid,path);
            });
            var shopimage = $("<td></td>").addClass("product-thumbnail product-thumbnail-2")
                .append($("<a></a>").attr("href",path + "/detail?goodsid="+item.goodsid)
                    .append($("<img/>").attr("src",path + "/shopImage/"+item.imagePaths[0].path)));
            var goodsname = $("<td></td>").addClass("product-name product-name_2")
                .append($("<a></a>").attr("href",path + "/detail?goodsid="+item.goodsid).append(item.goodsname));
            var goodsprice = $("<td></td>").addClass("product-price")
                .append($("<span></span>").addClass("amount-list amount-list-2").append("￥"+item.price));
            var numIput = $("<input/>").addClass("num").attr("type","number").attr("value",item.num);
            var num = $("<td></td>").addClass("product-stock-status")
                .append($("<div></div>").addClass("latest_es_from_2")
                    .append(numIput));
            numIput.change(function () {
               updateCart(item.goodsid,$(this).val(),path);
            });
            var totalPrice = $("<td></td>").addClass("product-price")
                .append($("<span></span>").addClass("amount-list amount-list-2").append("￥"+item.price*item.num));
            var goodsitem = $("<tr></tr>")
                .append(shopimage)
                .append(goodsname)
                .append(goodsprice)
                .append(num)
                .append(totalPrice)
                .append(deleteCart)
                .appendTo("#cart-table tbody");
            totalnum++;
            totalMoney = totalMoney + item.price * item.num;
        });
    }
    //小计
    $("#total-num").text(totalnum);
    $("#total-price").text("￥"+totalMoney);
}
