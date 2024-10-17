<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>���ż���</title>

	<!-- ���� : http://getbootstrap.com/css/ ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   	<link href="/css/animate.min.css" rel="stylesheet">
   	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
    </style>
    
</head>

<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td> ${purchase.purchaseProd.prodNo} </td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td> ${purchase.buyer.userId} </td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
			<c:if test="${ purchase.paymentOption == '1' }"> ���ݱ��� </c:if>
			<c:if test="${ purchase.paymentOption == '2' }"> �ſ뱸�� </c:if>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td> ${purchase.receiverName} </td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td> ${purchase.receiverPhone} </td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td> ${purchase.divyAddr} </td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td> ${purchase.divyRequest} </td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td> ${purchase.divyDate} </td>
		<td></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="/purchase/listPurchase">Ȯ��</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>
