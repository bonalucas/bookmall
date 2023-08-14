$(document).ready(function(){
    var oldPswflag = 0;
    var newPswflag = 0;
    $("#name").val($("#nameVal").text());
    $("#email").val($("#emailVal").text());
    $("#telephone").val($("#telephoneVal").text());

    // 弹出修改信息弹窗
    $("#changeInfo").click(function(){
        $("#update-info").modal({
            backdrop:'static'
        });
    });

    // 保存修改信息单击事件
    $("#saveInfo").click(function (){
        var saveInfo = {};
        var path = $(this).val();
        saveInfo.name = $("#name").val();
        saveInfo.email = $("#email").val();
        saveInfo.telephone = $("#telephone").val();
        $.ajax({
            type: "POST",
            url: path + "/saveInfo",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:saveInfo,
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

    // 弹出修改密码弹窗
    $("#changePsw").click(function (){
        $("#update-Psw").modal({
            backdrop:'static'
        });
    });

    // 旧密码失去焦点事件
    $("#oldPsw").blur(function (){
        // 判断旧密码是否一致
        if ($("#oldPsw").val() !== $("#Psw").attr("Psw")) {
            $("#oldPswError").show();
        } else {
            $("#oldPswError").hide();
            oldPswflag=1;
        }
    })

    // 新密码大于六位提示
    $("#newPsw").blur(function (){
        if($("#newPsw").val().length < 6)
        {
            $("#newPswError").show();
        }
        else {
            $("#newPswError").hide();
            newPswflag = 1;
        }
    });

    // 修改密码单击事件
    $("#savePsw").click(function (){
        if (oldPswflag === 1 && newPswflag === 1) {
            var Psw = {};
            var path = $(this).val();
            Psw.Psw = $("#newPsw").val();
            $.ajax({
                type: "POST",
                url: path + "/savePsw",
                contentType:"application/x-www-form-urlencoded; charset=utf-8",
                data:Psw,
                dateType:"json",
                success: function(result){
                    if (result.msg === "更新失败")
                    {
                        swal(result.msg);
                    }
                    else {
                        $("#update-info").modal('hide');
                        swal(result.msg);
                        $("button").click(function (){
                            location.reload();
                        });
                    }
                },
                error:function (){
                    alert("更新失败");
                }
            });
        }
    })

});
