<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>��ǰ��������</title>

	<!-- ���� : http://getbootstrap.com/css/ ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Date-Picker Plugin -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
	
	
	<!-- //////////////////////// CSS //////////////////////// -->
	<style>
	
 		body {
            padding-top : 50px;
        }
        
		img.upload_file {
			margin-top:10px; 
			margin-right:10px;
  			max-width: 700px;
		}
		
    </style>
    
	<!-- //////////////////// JavaScript //////////////////// -->
	<script type="text/javascript">
	
		//Form ��ȿ�� ����
		function fncUpdateProduct()
		{
			var name = $(".form-control[name='prodName']").val();
			var detail = $(".form-control[name='prodDetail']").val();
			var manuDate = $(".form-control[name='manuDate']").val();
			var price = $(".form-control[name='price']").val();
		
			if ( name == null || name.length < 1 ) {
				alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if ( detail == null || detail.length < 1 ) {
				alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if ( manuDate == null || manuDate.length < 1 ) {
				alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if ( price == null || price.length < 1 ) {
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			else if ( isNaN(Number(price)) ) {
				alert("���ݿ��� ���ڸ� �Է��ϼž� �մϴ�.");
				return;
			}
	
			$("form").attr("method", "POST")
					 .attr("enctype", "multipart/form-data")
					 .attr("action", "/product/updateProduct")
					 .submit();
		}
		
		//==> Event �߻� ó��
		$(function() {
			
			//==> "����" Event ����
			$( "button.btn-primary" ).bind("click" , function() {
				fncUpdateProduct();
			});
			
			//==> "���" Event ó�� �� ����
			$( "form-group a[href='#']" ).bind("click" , function() {
				$("form")[0].reset();
			});

			//==> �������� �޷� ��ư Ŭ�� Event
			$("#dateBtn").datepicker({
				format: 'yyyy-mm-dd',
		        endDate: '0d',
		        autoclose: true,
		        todayHighlight: true
			})	// ��ư���� ��¥ ���� �� text�� ����
			.bind("changeDate", function(date) {
				$(".form-control[name='manuDate']").val(date.format(0, "yyyy-mm-dd"));
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
			<h3 class="text-info">��ǰ��������</h3>
	    </div>
	    
		<!-- form Start ////////////////////////////////////////// -->
		<form class="form-horizontal">
		
			<!-- ��ǰ��ȣ -->
			<input type="hidden" name="prodNo" value="${product.prodNo}"/>
		
			<!-- ��ǰ�� -->
			<div class="form-group">
				<label for="prodName" class="col-sm-2 control-label">��ǰ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="prodName" 
							placeholder="��ǰ��" value="${product.prodName}">
				</div>
			</div>
			
			<hr/>
			
			<!-- ��ǰ������ -->
			<div class="form-group">
				<label for="prodDetail" class="col-sm-2 control-label">��ǰ������</label>
				<div class="col-sm-6">
    				<textarea class="form-control" name="prodDetail" rows="3" 
    						placeholder="��ǰ������">${product.prodDetail}</textarea>
				</div>
			</div>
			
			<hr/>
			
			<!-- �������� -->			
			<div class="form-group">
				<label for="manuDate" class="col-sm-2 control-label">��������</label>
				<div class="col-sm-3">
				    <div class="input-group">
				      	<input type="text" class="form-control" name="manuDate" 
				      			placeholder="YYYY-MM-DD or yyyyMMdd" value="${product.manuDate}">
				      	<span class="input-group-btn" data-date-end-date="0d">
				        	<button class="btn btn-default" type="button" id="dateBtn">
								<i class="glyphicon glyphicon-calendar"></i>
							</button>
				      	</span>
			    	</div>
				</div>
		    </div>
		    
		    <hr/>
		
			<!-- ���� -->
			<div class="form-group">
				<label for="price" class="col-sm-2 control-label">����</label>
				<div class="col-sm-3">
					<div class="input-group">
					  	<input type="text" class="form-control" name="price" value="${product.price}">
		      			<div class="input-group-addon">��</div>
					</div>
				</div>
			</div>
		    
		    <hr/>

		    <!-- ��ǰ�̹��� -->
			<div class="form-group">
			    <label for="fileData" class="col-sm-2 control-label">��ǰ�̹���</label>
			    <div class="col-sm-3">
				    <input type="file" name="fileData">
					<img class="img-rounded upload_file" src="/product/json/getImageFile/${product.fileName}" >
				</div>
			</div>
			<!-- �̹��������̸� -->
			<input type="hidden" name="fileName" value="${product.fileName}"/>
		    
		    <hr/>
		    
			<!-- ���/��� ���� -->
		  	<div class="form-group">
			    <div class="col-sm-offset-4 col-sm-4 text-center">
			      <button type="button" class="btn btn-primary">��&nbsp;��</button>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
			    </div>
		  	</div>
			
		</form>
		<!-- form end ////////////////////////////////////////// -->
		
 	</div>
 	<!-- ȭ�鱸�� div end ////////////////////////////////////// -->

</body>

</html>