<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>后台添加商品管理</title>
    <meta name="description" content="">
    <meta name="author" content="templatemo">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/templatemo-style.css" rel="stylesheet">
    <link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/image/favicon.gif">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sweetalert.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
</head>
<body>
<div class="templatemo-flex-row">
    <jsp:include page="sidebar.jsp"/>
    <div class="templatemo-content col-1 light-gray-bg">
        <jsp:include page="goodsNav.jsp"/>
        <div class="templatemo-content-container">
            <div class="templatemo-content-widget white-bg">
                <h2 class="margin-bottom-10">添加商品</h2>
                <p>商品的一些基本信息</p>
                <form action="${pageContext.request.contextPath}/admin/goods/addGoodsSuccess" class="templatemo-login-form" method="post" enctype="multipart/form-data">
                    <div class="row form-group">
                        <div class="col-lg-12 form-group">
                            <label class="control-label" for="inputWithSuccess">商品名称</label>
                            <input type="text" class="form-control" id="inputWithSuccess" name="goodsname">
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-6 form-group">
                            <label class="control-label" for="inputWithWarning">价格</label>
                            <input type="number" class="form-control" id="inputWithWarning" name="price">
                        </div>
                        <div class="col-lg-6 form-group">
                            <label class="control-label" for="inputWithError">数量</label>
                            <input type="number" class="form-control" id="inputWithError" name="num">
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-12 form-group">
                            <label class="control-label" for="inputNote">商品描述</label>
                            <textarea class="form-control" id="inputNote" rows="3" name="description"></textarea>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-6 col-md-6 form-group">
                            <label class="control-label templatemo-block">类别</label>
                            <select class="form-control" name="category">
                                <c:forEach items="${categoryList}" var="item">
                                    <option value="${item.cateid}">${item.catename}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-lg-6 col-md-6 form-group">
                            <label class="control-label" for="inputWithSuccess2">详细类别</label>
                            <input type="text" class="form-control" id="inputWithSuccess2" name="detailcate">
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-12">
                            <label class="control-label templatemo-block">图片</label>
                            <input type="file" name="fileToUpload" id="fileToUpload" class="filestyle" data-buttonName="btn-primary" data-buttonBefore="true" data-icon="false" multiple="multiple">
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <button type="submit" class="templatemo-blue-button">添加</button>
                        <button type="reset" class="templatemo-white-button">重置</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-filestyle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/admin/templatemo-script.js"></script>
<c:if test="${!empty msg}">
    <script type="text/javascript">
        $(document).ready(function () {
            swal('${msg}', '成功', 'success');
        });
    </script>
</c:if>
</body>
</html>

