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
		.list-group {
            padding-top : 20px;
		}
		.thumbnail {
		    margin-bottom: 20px;
		    padding: 0px;
		    -webkit-border-radius: 0px;
		    -moz-border-radius: 0px;
		    border-radius: 0px;
		}
		/*  .item.list-group-item  */ 
		img.list-group-image {
			justify-content: center;
		    width: 400px;
  			height: 250px;
  			object-fit: contain;
		}
		.list-group-item-text {
		    margin: 0 0 11px;
		}
		p.sold-out {
		    color: red;
		}
		.caption.sold-out {
		    background: #eeeeee;
		}
        /* 
		.glyphicon { 
			margin-right:5px;
		} 
		*/
		/* 
		.item.list-group-item {
		    float: none;
		    width: 100%;
		    background-color: #fff;
		    margin-bottom: 10px;
		}
		.item.list-group-item:nth-of-type(odd):hover, .item.list-group-item:hover {
		    background: #428bca;
		}
		 */
		/* 
		.item.list-group-item .thumbnail {
		    margin-bottom: 0px;
		}
		.item.list-group-item .caption {
		    padding: 9px 9px 0px 9px;
		}
		.item.list-group-item:nth-of-type(odd) {
		    background: #eeeeee;
		}
		
		.item.list-group-item:before, .item.list-group-item:after {
		    display: table;
		    content: " ";
		}
		
		.item.list-group-item img {
		    float: left;
		}
		.item.list-group-item:after {
		    clear: both;
		} 
		*/
		
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
			//$("#currentPage").val( Number($("#currentPage").val())+1 );
			
			$("form").attr("method", "POST")
					 .attr("action", "/product/listProduct?menu=${param.menu}")
					 .submit();
			/* 
			var formData = $("form").serializeArray();
			var formObj = {};
			formData.forEach( (element) => {
				formObj[element[name]] = element[value] 
			});
			
			fetchProductList(formObj); 
			*/
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
			

			//==> CSS(Grid View) �����ϱ�
			$( ".thumbnail .btn-success:not([disabled])" ).bind("click", function() {
				var prodNo = $(this).parents(".thumbnail").children(":last").val();
				self.location = "/product/getProduct?menu=search&prodNo="+prodNo;	
			});
			
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
			
			//==> ���� ��ũ��
			window.addEventListener('scroll', function() {
				// ��ũ���� �ٴڿ� ���� ������ �ƹ��͵� ����
			    if ((window.innerHeight + window.scrollY) < document.body.offsetHeight) {
			        return;
			    }
			    
				// 
			    if ( true /* !isFetching || hasMore */ ) {
			    	//fncGetProductList();
			    }
			});
		});
			
		/* 
		let isFetching = false;
		let hasMore = true;

		let root = document.getElementById('root');

		async function fetchData() {
		    isFetching = true;
		    let response = await fetch(`https://jsonplaceholder.typicode.com/posts?_page=${currentPage}`);
		    let data = await response.json();
		    console.log(data);

		    isFetching = false;

		    if (data.length === 0) {
		        hasMore = false;
		        return
		    }

		    for(let post of data) {
		        let div = document.createElement('div');
		        div.innerHTML = `<h2>${post.title}</h2><p>${post.body}</p>`
		        root.appendChild(div);
		    }
		    currentPage++;
		   
		} */
		
		function fetchProductList(formObj) 
		{
			console.log(formObj,JSON.stringify(formObj))
			$.ajax(
					{
						url : "/product/json/listProduct",
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data : JSON.stringify(formObj),
						success : function(JSONData , status) {
							
							var totalCount = JSONData.totalCount;
							var list = JSONData.list;
							
							list.forEach( (product) => {
								
								var item = $("<div class='item col-xs-4 col-lg-4'>");
								var thumbnail = $("<div class='thumbnail'>");
									var img = $("<img class='group list-group-image' src='/product/json/getImageFile/${product.fileName}'/>");
									var caption = $("<div class='caption'>");
									var heading = $("<h4 class='group inner list-group-item-heading'>{product.prodName}</h4>");
									var text = $("<p class='group inner list-group-item-text'>${product.regDate}</p>");
									var row = $("<div class='row'><div>");
									var price = $("<div class='col-xs-12 col-md-5'><p class='lead'>${product.price}��</p></div>");
									var sold = $("<div class='col-xs-12 col-md-4'></div>");
										var insold = $("<p class='lead sold-out'>sold out</p>");
									var open = $("<div class='col-xs-12 col-md-1'></div>");
		                           		var inopen = $("<a class='btn btn-success></a>");
		    						var prodNo = $("<input type='hidden' value='${product.prodNo}'>");

								if (${ product.proTranCode == null }) 
								{
									caption.addClass("sold-out");
									insold.html("sold out");
									inopen.addClass("disabled");
								}
								sold.append(insold);
								open.append(inopen);
								thumbnail.append(img,caption,heading,text,row,price,sold,open,prodNo);
								$(".list-group").append(item,thumbnail);
							});
							
						},
						error: function() {
							console.log("asd");
						}
					}
			);
			// ajax end
		}

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
					<div class="form-group">
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
					<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
					
				</form>
			</div>
			
	    </div>
	    <!-- table ���� �˻� end /////////////////////////////////////-->
		
		<!-- product list grid view start //////////////////////// -->
	 	<div class="container">
			<div class="row list-group">
			
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					
			        <div class="item col-xs-4 col-lg-4">
			            <div class="thumbnail">
			                <img class="group list-group-image" src="/product/json/getImageFile/${product.fileName}" />
			                <div class="caption ${ empty product.proTranCode ? 'sold-out' :'' }">
			                    <h4 class="group inner list-group-item-heading">
			                        ${product.prodName}
			                    </h4>
			                    <p class="group inner list-group-item-text">
			                        ${product.regDate}
			                    </p>
			                    <div class="row">
			                        <div class="col-xs-12 col-md-5">
			                            <p class="lead">${product.price}��</p>
			                        </div>
			                        <div class="col-xs-12 col-md-4">
			                            <p class="lead sold-out">${ empty product.proTranCode ? ' sold out' :'' }</p>
			                        </div>
			                        <div class="col-xs-12 col-md-1">
			                            <a class="btn btn-success" ${ empty product.proTranCode ? 'disabled' :'' }>
			                            	��
			                            </a>
			                        </div>
			                    </div>
			                </div>
					  		<input type="hidden" value="${product.prodNo}">
			            </div>
			        </div>
		        
		        </c:forEach>
		        
			</div>
		</div>
		<!-- product list grid view end ////////////////////////// -->
		
		<%-- 
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
		 --%>
	  
	</div>
 	<!--  ȭ�鱸�� div End ///////////////////////////////////// -->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator.jsp"/>
	<!-- PageNavigation End... -->

</body>

</html>