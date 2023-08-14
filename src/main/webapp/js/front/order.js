$(document).ready(function () {
    var path = $("#path").text();
    $("#confirm-orders").click(function () {
        var selectAddr =  $('input:radio[name="addressid"]:checked').val();
        if(selectAddr == null) {
            swal("请先添加地址");
            return;
        }
        var isPay = $('#pay-select').val();
        var oldPrice = $('#total-old').text();
        var newPrice = $('#total-new').text();
        $.ajax({
            url: path + "/orderFinish",
            type: "POST",
            data: {
                oldPrice: oldPrice,
                newPrice: newPrice,
                isPay: isPay,
                addressid: selectAddr
            },
            success: function () {
                swal("购买成功", "", "success");
                location.href = path + "/info/list"
            },
            error: function () {
                swal("购买失败，无法连接到服务器！");
            }
        });
    });
});