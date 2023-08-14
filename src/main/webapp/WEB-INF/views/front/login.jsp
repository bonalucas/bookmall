<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Aba-欢迎登录</title>
	<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
	<link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/image/favicon.gif">
	<script type="text/javascript" src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/front/sort.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/holder.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/front/login.js"></script>
</head>

<script type="text/javascript">
	function reloadcode() {
		var verify = document.getElementById('code');
		verify.setAttribute("src", "${pageContext.request.contextPath}/verificationcodeimg?it=" + Math.random());
	}
</script>

<body>
	<div id="main" class="container">
		<div id="header">
			<%@ include file="header.jsp"%>
		</div>
		<div class="login">
			<div class="row">
				<div class="col-md-6">
					<img src="${pageContext.request.contextPath}/image/login.jpg" alt="" width="600" height="500" style="margin-left:-40px;margin-top:30px;">
				</div>
				<div class="col-md-5 form-login">
					<div>
						<form class="form-horizontal" id="form2" action="${pageContext.request.contextPath}/loginconfirm" method="post">
							<div class="form-group">
								<label for="username" class="col-sm-2 control-label">用户名</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="username"
										name="username" placeholder="用户名">
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-sm-2 control-label">密码</label>
								<div class="col-sm-10">
									<input type="password" class="form-control" id="password"
										name="password" placeholder="密码">
								</div>
							</div>
							<div class="form-group">
								<label for="confirmlogo" class="col-sm-2 control-label">验证码</label>
								<img src="${pageContext.request.contextPath}/verificationcodeimg" id="code" onclick="reloadcode()"
									style="cursor: pointer;" alt="看不清楚,换一张" width="100px">
								<div class="col-sm-10" style="width: 160px">
									<input type="text" class="form-control" id="confirmlogo"
										name="confirmlogo" placeholder="验证码">
								</div>
							</div>
							<div style="margin-left:80px;color:red;">
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<input type="submit" class="btn btn-primary login-input" value="登录"
										name="submit">
									<div class="error">
										${errorMsg}
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>