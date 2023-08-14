$(document).ready(function (){
    // 删除已完成订单
    $("[name='deleteList']").click(function (){
        var orderid=$(this).parents("[name='parent']").find("[name='orderid']").text();
        var order={};
        var path = $(this).val();
        order.orderid= parseInt(orderid);
        $.ajax({
            type:"POST",
            url:path + "/deleteList",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:order,
            dataType:"json",
            success:function (result){
                swal(result.msg);
                $("button").click(function (){
                    location.reload();
                });
            },
            error:function (){
                alert("删除失败");
            }
        });
    });
    // 完成订单单击事件
    $("[name='finishList']").click(function (){
        var orderid=$(this).parents("[name='parent']").find("[name='orderid']").text();
        var order={};
        var path = $(this).val();
        order.orderid=orderid;
        $.ajax({
            type:"POST",
            url:path + "/finishList",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:order,
            dataType:"json",
            success:function (result){
                swal(result.msg);
                $("button").click(function (){
                    location.reload();
                });
            },
            error:function (){
                alert("点击失败");
            }
        });
    })

    var goodsId={};

    // 商品评论窗口单击事件
    $("[name='evaluate']").click(function (){
        $("#evaluate").modal({
            backdrop:'static'
        });
        goodsId=$(this).parents(".table-bordered").find(".col-lg-1").eq(0).text();
    })

    // 评价用的星星
    $("#star").raty({path : '../image/img'});

    // 保存评价单击事件
    $("#saveEvaluate").click(function (){
        var score=$("[name='score']").val();
        var content=$("#description").val();
        var comment={};
        var path = $(this).val();
        comment.commentid={};
        comment.userid={};
        comment.goodsid=goodsId;
        comment.point=score;
        comment.content=content;
        $.ajax({
            type:"POST",
            url:path + "/comment",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:comment,
            dataType:"json",
            success:function (result){
                $("#evaluate").modal('hide');
                swal(result.msg);
            },
            error:function (){
                alert("评论失败");
            }
        });
    })
});