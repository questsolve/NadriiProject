<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

	<!-- css -->
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
	<link href="/resources/css/jcarousel.css" rel="stylesheet" />
	<link href="/resources/css/flexslider.css" rel="stylesheet" />
	<link href="/resources/css/style.css" rel="stylesheet" />
	
	<!-- Theme skin -->
	<link href="/resources/skins/default.css" rel="stylesheet" />

	<!-- //////////////////// CSS //////////////////// -->

	<style type="text/css">

		.container {
			padding: 50px;
        }

	</style>

	<script type="text/javascript">
	
	//========== '나들이 정보' 버튼 처리 Event ==========
	$( function() {
		$("a[href='#' ]:contains('나들이 정보')").on("click" , function() {
			self.location = "../trip/getTheme"
		});
	});
	
	//========== '나들이 티켓' 버튼 처리 Event ==========
	$( function() {
		$("a[href='#' ]:contains('나들이 티켓')").bind("click" , function() {
			self.location = "/ticket/listTicket"
		});
	});
	
	//============= "장바구니" 화면이동 =============
    $( function() {
       $("glyphicon.glyphicon-shopping-cart").bind("click" , function() {
//      	 alert("장바구니")
          self.location = "/purchase/listBasket"
       });
    });
	
	</script>
	
</head>


<body>
		<nav class="navbar navbar-default navbar-static-top">
			<div class="container">
				

				<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
							data-target="#bs-example-navbar-collapse-1" >
	                        <span class="icon-bar"></span>
	                        <span class="icon-bar"></span>
	                        <span class="icon-bar"></span>
	                   	</button>
					<a class="navbar-brand" href="/index.jsp"><span>Na</span>drii</a>
				</div>
				<!-- navbar-header End -->

				
				<c:if test="${ ! empty loginUser }">
				<div class="navbar-collapse collapse ">
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="#">
								<c:if test="${ loginUser.userName eq null }">
									${ loginUser.userId }
								</c:if>
									${ loginUser.userName }
									님 환영합니다.
							</a>
						</li>
						<li>
							<a href="#">
								<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> 장바구니
							</a>
						</li>
					</ul>
				</div>
				</c:if>
			
					<ul class="nav navbar-nav navbar-right">
						<li class="active"><a href="../index.jsp">Home</a></li>
						<li><a href="#">나들이 정보</a></li>
						<li><a href="/comm/listComm">나만의 나들이</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle "
							data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">나들이 플래너 
							<b class=" icon-angle-down"></b></a>
									<ul class="dropdown-menu">
										<li><a href="/planner/listPlanner">플래너 게시판</a></li>
										<li><a href="/planner/addPlannerView.jsp">플래너 작성</a></li>
									</ul></li>
								<li><a href="#">나들이 티켓</a></li>
								<li><a href="/group/listGroup">나들이모임</a></li>
							</ul>
				</div>


			</div>
			<!-- Container End -->
		</nav>
		<!-- navbar End -->
</body>
</html>