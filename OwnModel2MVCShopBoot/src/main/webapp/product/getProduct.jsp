<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>��ǰ����ȸ</title>

	<!-- ���� : http://getbootstrap.com/css/ ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- //////////////////////// CSS //////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
    </style>
	
	<!-- //////////////////// JavaScript //////////////////// -->
	<script type="text/javascript">

		//==> Event �߻� ó��
		$(function() {

			//==> "����" Event ó�� �� ����
			$( "button.btn.btn-primary" ).bind("click" , function() {
				self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
			});
			
			//==> "Ȯ��" Event ó�� �� ����
			$( "a[href='#']" ).bind("click" , function() {
				history.go(-1);
			});
		
		});
		
	</script>

</head>


<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->
	
	<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
	<div class="container">
	
		<div class="page-header">
			<h3 class=" text-info">��ǰ����ȸ</h3>
	    </div>
	
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ǰ ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4">
				<img src="/product/json/getImageFile/${product.fileName}"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}&nbsp;��</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<hr/>
		
		<!-- ����/���� ���� -->
		<form class="form-horizontal">
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<c:if test="${ (product.proTranCode == null ) && (user.role == 'user') }">
						<button type="button" class="btn btn-primary">��&nbsp;��</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					<a class="btn btn-primary btn" href="#" role="button">Ȯ&nbsp;��</a>
				</div>
			</div>
		</form>
		
 	</div>
 	<!-- ȭ�鱸�� div end ////////////////////////////////////// -->

</body>

</html>