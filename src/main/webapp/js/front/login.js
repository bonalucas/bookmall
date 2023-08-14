// 拦截表单提交事件，执行完自定义代码后再提交表单内容
$.validator.setDefaults({
	submitHandler: function() {
		form.submit();
	}
});
// 表单验证
$(document).ready(function() {
	$('#form2').validate({
		//设置为必填字段
		rules: {
			username: "required",
			
			password: {
				required: true,
			},
			confirmlogo: "required",
		},
		messages: {
			username: "用户名输入不能为空",
			
			password: {
				required: "密码输入不能为空",
			},
			confirmlogo: "验证码输入不能为空",
		}
	});
});