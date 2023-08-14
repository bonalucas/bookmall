// 拦截表单提交事件，执行完自定义代码后再提交表单内容
$.validator.setDefaults({
	submitHandler: function() {
		form.submit();
	}
});
// 表单验证
$(document).ready(function() {
	$('#form').validate({
		rules: {
			username: "required",
            telephone: {
				required: true,
			},
            email: {
				required: true,
				email: true,
			},
            password: {
				required: true,
				minlength: 6,
			},
			confirmPassword: {
				required: true,
				minlength: 6,
				equalTo: "#password",
			}
		},
		messages: {
            username: "用户名不能为空",
            telephone: "联系电话不能为空",
            email: {
				required: "邮箱输入不能为空",
				email: "请输入一个正确的邮箱",
			},
            password: {
				required: "密码输入不能为空",
				minlength: "密码长度不能小于6位",
			},
			confirmPassword: {
				required: "输入不能为空",
				minlength: "密码长度不能小于6位",
				equalTo: "两次密码输入不一致",
			}
		}
	});
});