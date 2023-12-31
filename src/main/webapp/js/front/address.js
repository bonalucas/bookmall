$(document).ready(function (){
    var addresId;
    // 弹出修改地址窗口
    $("[name='changeAddr']").click(function (){
        $("#update-addr").modal({
            backdrop:'static'
        });
        $("#name").val($(this).parents("#parent").find("#conname").text());
        $("#telephone").val($(this).parents("#parent").find("#contel").text());
        $("#detailaddress").val($(this).parents("#parent").find("#detailaddr").text());
        addresId=$(this).parents("#parent").find("#table").attr("address-id");
    });


    $("#saveAddr").click(function (){
        var saveAddr={};
        var path = $(this).val();
        saveAddr.addressid=addresId;
        saveAddr.province=$("#provinceUpdate").val();
        saveAddr.city=$("#cityUpdate").val();
        saveAddr.county=$("#countyUpdate").val();
        saveAddr.detailaddr=$("#detailaddress").val();
        saveAddr.conname=$("#name").val();
        saveAddr.contel=$("#telephone").val();

        $.ajax({
            type: "POST",
            url: path + "/saveAddr",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:saveAddr,
            dateType:"json",
            success: function(result){
                if (result.msg === "更新失败")
                {
                    swal(result.msg);
                }
                else {
                    $("#update-info").modal('hide');
                    swal("修改成功", "", "success");
                    $("button").click(function (){
                        location.reload();
                    });
                }
            },
            error:function (){
                alert("更新失败");
            }
        });
    });

    // 删除地址单击事件
    $("[name='deleteAddr']").click(function (){
        addresId=$(this).parents("#parent").find("#table").attr("address-id");
        var address={};
        var path = $(this).val();
        address.addressid=addresId;
        $.ajax({
            type: "POST",
            url: path + "/deleteAddr",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:address,
            dateType:"json",
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

    // 弹出添加地址窗口
    $("[name='insertAddr']").click(function () {
        $("#insert-addr").modal({
            backdrop:'static'
        });
    });
    // 添加地址单击事件
    $("#insertAddr").click(function (){
        var insertAddr={};
        var path = $(this).val();
        insertAddr.addressid={};
        insertAddr.userid={};
        insertAddr.province=$("#provinceInsert").val();
        insertAddr.city=$("#cityInsert").val();
        insertAddr.county=$("#countyInsert").val();
        insertAddr.detailaddr=$("#detailaddressInsert").val();
        insertAddr.conname=$("#nameInsert").val();
        insertAddr.contel=$("#telephoneInsert").val();
        $.ajax({
            type:"POST",
            url:path + "/insertAddr",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:insertAddr,
            dataType:"json",
            success:function (result){
                swal(result.msg);
                $("button").click(function (){
                    location.reload();
                });
            },
            error:function (){
                alert("添加失败");
            }
        });
    });
});