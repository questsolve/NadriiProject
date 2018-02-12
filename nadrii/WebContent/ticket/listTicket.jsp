<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">

<title>나들이 티켓 목록</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="../resources/assets/css/main.css?version=1041" />
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<!-- //////////////////// JavaScript //////////////////// -->
<script type="text/javascript">
	function fncGetList(pageNo) {
		$("#pageNo").val(pageNo);
		$("form").attr("method", "POST").attr("action", "/ticket/listTicket")
				.submit();

	}

	//=================== "4 kind of sorting" Event 연결 =================== 
	$(function() {

		$("a[href='#']:contains('제목순')").bind("click", function(event) {
			//			alert("제목순")
			event.preventDefault();
			self.location = "/ticket/listTicket?searchCondition=A";
		})
	});

	$(function() {
		$("a[href='#']:contains('조회순')").bind("click", function(event) {
			event.preventDefault();
			self.location = "/ticket/listTicket?searchCondition=B";
		})
	});

	$(function() {
		$("a[href='#']:contains('수정일순')").bind("click", function(event) {
			event.preventDefault();
			self.location = "/ticket/listTicket?searchCondition=C";
		})
	});

	$(function() {

		$("a[href='#']:contains('생성일순')").bind("click", function(event) {
			event.preventDefault();
			self.location = "/ticket/listTicket?searchCondition=D";
		})
	});

	function fncGetTicketSort(searchCondition) {

		alert("[value check] ==> " + searchCondition)

		self.location = "/ticket/listTicket"

	}

	//=================== "상세조회" Event 연결 ===================
	$(function() {
		$("a[href='#' ]:contains('상세조회')").bind(
				"click",
				function(event) {
//					alert("상세조회")

					event.preventDefault();

					var contentId = $(
							$('input[name="contentId"]')[$(".button.small.fit").index(this)]).val();
					var contentTypeId = $(
							$('input[name="contentTypeId"]')[$(".button.small.fit").index(this)]).val();
					var title = $(
							$('input[name="title"]')[$(".button.small.fit").index(this)]).val();
					var encodeTitle = encodeURI(encodeURIComponent(title));
					
					console.log('contentId : ' + contentId)
					console.log('contentTypeId : ' + contentTypeId)
					console.log('title : ' + title)
					console.log('encodeTitle : ' + encodeTitle)

					self.location = "/ticket/getTicket?" + "contentId="
							+ contentId + "&contentTypeId=" + contentTypeId
							+ "&title=" + encodeTitle;

				});
	});

	function fncGetTicket() {
		$("form").attr("method", "POST").attr("action", "/ticket/getTicket")
				.submit();
	}
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<div id="main">

				<div class="page-header text-right">
					<h3>나들이 티켓</h3>
					<h5 class="text-muted">
						조회하실 티켓 정보를 <strong class="text-danger">선택</strong>해 주세요.
					</h5>
				</div>

				<!-- form Start /////////////////////////////////////-->
				<form class="form-horizontal">

				<ul class="actions fit">
					<li><a href="#" class="button fit">제목순</a></li>
					<li><a href="#" class="button fit">조회순</a></li>
					<li><a href="#" class="button fit">수정일순</a></li>
					<li><a href="#" class="button fit">생성일순</a></li>
				</ul>



				<div class="col-md-12 text-right">
						<p class="text-primary">&lt; 현재 ${ resultPage.pageNo } 페이지 /
							전체 ${ resultPage.totalCount } 건수 &gt;</p>
					</div>

					<hr />
					<section>
						<div class="row uniform">
							<c:forEach var="tt" items="${tourTicket}" varStatus="num">
							
							<div class="3u 12u$(mobile)">
							<article class="item">
								<a href="#" class="image fit">
								<img src="${ tt.firstimage }" alt="" />
								</a>
								<header>
									<h3>
										<a href="#">${tt.title}</a>
									</h3>
									<time class="published" datetime=""> 기&nbsp;간 : ${ tt.eventstartdate } ~ ${ tt.eventenddate } </time>
									<span class="author">
										<img src="../resources/assets/images/avatar.jpg" alt="" />
									</span>
								</header>
							</article>
						</div>
							
							
							
							
							
								<div class="col-sm-3">
									<!-- Mini Posts -->
									<section>
										<div class="mini-posts">

											<!-- Mini Post -->
											<article class="mini-post">
												<header>
													<h4>${ num.count }.${ tt.title }</h4>

													<time class="published" datetime=""> 기&nbsp;간 : ${ tt.eventstartdate }
														~ ${ tt.eventenddate } </time>
													<a href="#" class="author">
														<img src="/resources/imperfect/images/pic08.jpg" alt="" /></a>
													<ul class="actions vertical small">
														<li><a href="#" class="button small fit">상세조회</a></li>
													</ul>

												</header>
												<p class="text-right">조회수 : ${ tt.readcount }&nbsp;&nbsp;</p>
												<a href="#" class="image"> 
													<img src="${ tt.firstimage }" alt="" />
												</a>

											</article>
										</div>
									</section>
								</div>

								<!-- PageNavigation을 위한 값을 보내는 부분  -->
								<input type="hidden" name="contentId" value="${ tt.contentid }">
								<input type="hidden" name="contentTypeId" value="${ tt.contenttypeid }">
								<input type="hidden" name="title" value="${ tt.title }">
								<input type="hidden" name="eventstartdate" value="${ tt.eventstartdate }">
								<input type="hidden" name="eventenddate" value="${ tt.eventenddate }">

							</c:forEach>
						</div>
					</section>

					<hr />
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="pageNo" name="pageNo" value="" /> 
					<input type="hidden" name="searchCondition" id="searchCondition" value="">

				</form>
				<!-- form End /////////////////////////////////////-->

			</div>
			<!--  화면구성 div End /////////////////////////////////////-->
	</div>



	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_openApi.jsp" />
	<!-- PageNavigation End... -->

	<!-- Scripts -->
	<script src="/resources/imperfect/assets/js/jquery.min.js"></script>
	<script src="/resources/imperfect/assets/js/skel.min.js"></script>
	<script src="/resources/imperfect/assets/js/util.js"></script>
	<!--[if lte IE 8]><script src="/resources/imperfect/assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="/resources/imperfect/assets/js/main.js"></script>
	
	
	
	
	
</body>

</html>