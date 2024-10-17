<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>��ǰ�����ȸ</title>

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

		//==> pageNavigator ����
		function fncPageUp(currentPage) {
			fncGetProductList(currentPage);
		}
		
		//==> �˻� / ����¡
		function fncGetProductList(currentPage)
		{		 
			if ( $(".form-control[name='searchCondition']").val() == "0" )
			{
				if ( isNaN(Number( $(".form-control[name='searchKeyword']").val() )) )
				{
					alert("��ǰ��ȣ���� ���ڸ� �Է��ϼž� �մϴ�.");
					return;
				}
			}

			var startPrice = $(".form-control[name='startSearchRange']");
			var endPrice = $(".form-control[name='endSearchRange']");

			if ( $( "input[aria-label='price']" ).is(":checked") &&
				 ( (startPrice.val() != "") || (endPrice.val() != "") ) )
			{
				if ( isNaN( Number(startPrice.val()) ) ||
					 isNaN( Number( endPrice.val() ) )	)
				{
					alert("��ǰ���ݿ��� ���ڸ� �Է��ϼž� �մϴ�.");
					return;
				}
				else if ( (startPrice.val() < 0) || (endPrice.val() < 0) ) 
				{
					alert("��ǰ������ 0���� ���� �� �����ϴ�.");
					return;
				}
				else if ( ( Number(startPrice.val()) > Number(endPrice.val()) ) &&
						  ( (startPrice.val() != "") && (endPrice.val() != "") ) )
				{
					alert("�ִ�ݾ��� �ּұݾ׺��� ���� �� �����ϴ�.");
					return;
				}
			}
			else 
			{
				startPrice.val("");
				endPrice.val("");
			}
			
			$("#currentPage").val(currentPage)
			
			$("form").attr("method", "POST")
					 .attr("action", "/product/listProduct?menu=${param.menu}")
					 .submit();
		}
		
		//==> �˻�,��ǰȮ��,����,���� Event ó��
		$(function() {
			
			//==> �˻�
			$( "button.btn.btn-default" ).bind("click", function() {
				fncGetProductList(1);
			});

			//==> ���� ���� �˻� on/off
			$( "input[aria-label='price']" ).bind('change', function() {

				if ($(this).is(":checked")) {
					$(this).parent().siblings(".form-control").attr("readonly", false);
				} 
				else {
					$(this).parent().siblings(".form-control").attr("readonly", true);
				}
			});
			
			//==> ���� ���� �˻� �ʱ�ȭ
			$(function() {
			
				var priceRange = $( "input[aria-label='price']" );
				var startPrice = $(".form-control[name='startSearchRange']");
				var endPrice = $(".form-control[name='endSearchRange']");
			
				if ( (startPrice.val() == "") && (endPrice.val() == "") ) 
				{
					priceRange.attr("checked", false);
					startPrice.val("").attr("readonly", true);
					endPrice.val("").attr("readonly", true);
				}
				else 
				{
					priceRange.attr("checked", true);
					startPrice.attr("readonly", false);
					endPrice.attr("readonly", false);
				}
			});
			
			/* 
			//==> �˻� ���� ���� Event �߻� �� �Է� â ����
			$( "select[name='searchCondition']" ).bind("change", function() {
				
				if ( $(this).val() == '2' ) 
				{
					$("span:has(input[name='searchKeyword'])").css("display", "none");
					$("span:contains('~')").css("display", "inline-block");
				}
				else
				{
					$("span:has(input[name='searchKeyword'])").css("display", "inline-block");
					$("span:contains('~')").css("display", "none");
				}
				
			}); 
			*/
			
			
			//==> manage �� �� ���ŵ� ��ǰ�� click Event
			if ( ${ param.menu == 'manage' } ) 
			{
				$( "tr:has( span:not(:contains('�Ǹ���')) ) td:nth-child(2)" ).bind("click", function() {
					
					var prodNo = $(this).siblings(":last").children("i").attr("id");
					self.location = "/product/getProduct?menu=search&prodNo="+prodNo;	
					
				}).css("color", "blue");
				//==> click event ����� ��ǰ�� �� ����
			}
			
			//==> '�Ǹ���' ��ǰ�� click Event ���� �� ó��
			//$( ".ct_list_pop:has(span:contains('�Ǹ���')) td:nth-child(3)" ).bind("click", function() {
			$( "tr:has(span:contains('�Ǹ���')) td:nth-child(2)" ).bind("click", function() {
					
				var prodNo = $(this).siblings(':last').children("i").attr("id");
				
				if ( ${ param.menu == 'manage' } ) 
				{
					self.location = "/product/updateProduct?menu=manage&prodNo="+prodNo;
				}
				else if ( ${ param.menu == 'search' } )
				{
					self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
				}
			
			}).css("color", "red"); 
			//==> click event ����� ��ǰ�� �� ����
			
			//==> (click:������) �� ����
			//$("h7").css("color" , "red");
			
			
			//==> ����ϱ� click Event -> ��ǰ���� ����(�����)
			$( "tr > td > a" ).css("color", "red").bind("click", function() {

				var prodNo = $(this).parent().next().children("i").attr("id");
				var thisProd = $(this);
				
				//self.location = "/purchase/updateTranCodeByProd?tranCode=2&prodNo="+prodNo;
				$.ajax(
						{
							url : "/purchase/json/updateTranCodeByProd/2/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(data , status) {
								
								if (data === false) {
									alert("��� ó���� ���� �߻�");
									return;
								}
								
								alert( prodNo + "�� ��ǰ \n��� ��û �Ϸ�" );
								thisProd.prev().text("�����");
								thisProd.text("");
								
							}, 
							error : function() {
								alert("��� ��û ����");
							}
						}
				);
				// ajax end
			});
			
			
			//==> �������� Ŭ�� �� ������ ���
			//$( ".ct_list_pop td:nth-child(1)" ).bind("click", function() {
			$( "td:nth-child(6) > i" ).bind("click", function() {
			
				var prodNo = $(this).attr("id");
				
				$.ajax(
						{
							url : "/product/json/getProduct/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								var displayValue = "<h6>"
													+"��ǰ�� : "+JSONData.prodName+"<br>"
													+"������ : "+JSONData.prodDetail+"<br>"
													+"������ : "+JSONData.manuDate+"<br>"
													+"�� �� : "+JSONData.price+"<br>"
													+"����� : "+JSONData.regDateString+"<br>"
													+"</h6>";

								var thisProd = $( "i[id='"+prodNo+"']" );
								
								if (thisProd.html() != displayValue) 
								{
									$("h6").remove();
									thisProd.html(displayValue);
								}
								else {
									thisProd.html("");
								}
								
							}
						}
				);
				// ajax end
			});
			
			//==> ¦����° row ���� ����			
			//$( ".ct_list_pop:odd" ).css("background-color" , "whitesmoke");
			
		});

</script>

</head>

<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->

	<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
	<div class="container">
	
		<div class="page-header text-info">
			<h3>
				<c:if test="${ param.menu == 'manage' }">
					��ǰ����
				</c:if>
				<c:if test="${ param.menu == 'search' }">
					��ǰ�����ȸ
				</c:if>
			</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
	    	<div class="col-md-5 text-left">
				<p class="text-primary">
		    		��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������
		    	</p>
		    </div>
	    
		    <div class="col-md-7 text-right">
		    	<!-- �˻� form -->
				<form class="form-inline" name="detailForm">
				
					<!-- ���ı��� -->
					<div class="form-group">
						<select class="form-control" name="sortColumn">
							<option value="0" ${ ! empty search.sortColumn && search.sortColumn==0 ? 'selected' : ''}>�����</option>
							<option value="1" ${ ! empty search.sortColumn && search.sortColumn==1 ? 'selected' : ''}>��ǰ��</option>
							<option value="2" ${ ! empty search.sortColumn && search.sortColumn==2 ? 'selected' : ''}>��ǰ����</option>
						</select>
				  	</div>
				  	<!-- ���ļ��� -->
					<div class="form-group">
						<select class="form-control" name="sortOrder">
							<option value="0" ${ ! empty search.sortOrder && search.sortOrder==0 ? 'selected' : ''}>��������</option>
							<option value="1" ${ ! empty search.sortOrder && search.sortOrder==1 ? 'selected' : ''}>��������</option>
						</select>
				  	</div>
					&nbsp;
						
					<!-- �˻����� -->
					<div class="form-group">
						<select class="form-control" name="searchCondition">
							<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? 'selected' : ''}>��ǰ��ȣ</option>
							<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? 'selected' : ''}>��ǰ��</option>
							<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? 'selected' : ''}>��ǰ����</option>
						</select>
				  	</div>
				  	<!-- �˻��� -->
					<div class="form-group" <%-- style="display:${ search.searchCondition==2 ? 'none' : 'inline-block'};" --%>>
						<label class="sr-only" for="searchKeyword">�˻���</label>
						<input type="text" class="form-control" name="searchKeyword" placeholder="�˻���"
								value="${ ! empty search.searchKeyword ? search.searchKeyword : '' }">
					</div>
					  	
					<!-- �˻� ��ư -->
					<button type="button" class="btn btn-default">�˻�</button>


					<!-- ���� -->
					<div class="form-group text-right" style="margin:8px;">
						<div class="input-group col-md-10">
							<span class="input-group-addon">
								���ݹ���
								<input type="checkbox" aria-label="price">
							</span>
							<input type="text" class="form-control" name="startSearchRange"
									placeholder="�ּұݾ�" value="${search.startSearchRange}">
				      		<div class="input-group-addon"> ~ </div>
							<input type="text" class="form-control" name="endSearchRange"
									placeholder="�ִ�ݾ�" value="${search.endSearchRange}">
						</div>
					</div>
					
					<!-- PageNavigation ���� ������ ���� ������ �κ� -->
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					
				</form>
			</div>
			
	    </div>
	    <!-- table ���� �˻� end /////////////////////////////////////-->
		
	    <!-- table Start /////////////////////////////////////-->
      	<table class="table table-hover table-striped">
      
      		<thead>
				<tr>
		            <th align="center">No</th>
		            <th align="left">��ǰ��</th>
		            <th align="left">����</th>
		            <th align="left">�����</th>
		            <th align="left">�������</th>
		            <th align="left">��������</th>
	          	</tr>
			</thead>
      
			<tbody>
				<!-- ��ǰ ���� ��� ��� -->
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					
					<tr>
					  	<td align="center">${ i }</td>
					  	<td align="left" title="Click : ��ǰ���� Ȯ��">
					  		${product.prodName}
					  	</td>
					  	<td align="left">${product.price}</td>
					  	<td align="left">${product.regDate}</td>
					  	<td>
							<span>
								<c:if test="${ param.menu=='manage' }">${product.proTranCodeString}</c:if>
								<c:if test="${ param.menu=='search' }">
									${ (empty product.proTranCode) ? '�Ǹ���' : '��� ����' }
								</c:if>
							</span>
							<a>
								${ (param.menu=='manage' && product.proTranCode=='1') ? '����ϱ�' : '' }
							</a>
					  	</td>
					  	<td align="left">
					  		<i class="glyphicon glyphicon-ok" id="${product.prodNo}"></i>
					  		<input type="hidden" value="${product.prodNo}">
					  	</td>
					</tr>
					
				</c:forEach>
			</tbody>
			
      	</table>
		<!-- table End ///////////////////////////////////// -->
	  
	</div>
 	<!--  ȭ�鱸�� div End ///////////////////////////////////// -->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator.jsp"/>
	<!-- PageNavigation End... -->

</body>

</html>