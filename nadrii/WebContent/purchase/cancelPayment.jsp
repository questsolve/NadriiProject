<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">

<title>구매완료</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- //////////////////// CSS //////////////////// -->
	<style>
    </style>

<!-- //////////////////// JavaScript //////////////////// -->
<script type="text/javascript">

$(function(){
	$( "btn.btn-default.btn-lg" ).bind("click", function(){
		self.location = "/index.jsp"
	});
});

	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="jumbotron">
			<h1 class="text-center text-danger">결제가 <code>취소</code> 되었습니다.</h1>
			<p>
				구매하신 티켓의 결제가 취소 되었습니다.
			</p>
			<p>
				확인버튼 클릭시 나드리 메인화면으로 이동합니다.
			</p>
			<p>
				<a class="btn btn-default btn-lg" href="#" role="button">
					확인
				</a>
			</p>
		</div>
		<!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
</body>
</html>