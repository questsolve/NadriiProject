<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="../resources/helios/assets/css/main.css" />
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<script type="text/javascript">

	$( function() {

		$("img[name='museum']").on("click" , function() {
			self.location = "../trip/listMuseum?pageNo=1&area=local"
		});
	});
	
	$( function() {

		$("img[name='exhibition']").on("click" , function() {
			self.location = "../trip/listExhibit?pageNo=1&area=local"
		});
	});
	
	$( function() {

		$("img[name='gallery']").on("click" , function() {
			self.location = "../trip/listGallery?pageNo=1&area=local"
		});
	});
	
	$( function() {

		$("img[name='experience']").on("click" , function() {
			self.location = "../trip/listExperience?pageNo=1&area=local"
		});
	});
	
	$( function() {
		$("img[name='tradition']").on("click" , function() {
			self.location = "../trip/listTradition?pageNo=1&area=local"
		});
	});
	
	$( function() {
		$("#search").on("click" , function() {
				var keyword = $(".form-control").val();
				$("form input:nth-child(2)").val(1);
				$("form").attr("method","POST").attr("action","/trip/listSearch").submit();
			
		});
		
		$('#searchKeyword').keydown(function(key) {
			var data = $(this).val();
			if(key.keyCode==13){
				if(data!=""){
					$('form').attr('method', 'POST').attr('action', '../trip/listSearch').submit();
				}else{	
		 			alert("검색어를 입력해주세요");
				}
			}
		});
		
	});
	

</script>

 
<style type="text/css">
#header {
	background-color: #ffffcd;
	background-image: url("/resources/images/tripIcon/tripInfo.jpg");
}

#nav {
	background-image: url("../resources/helios/images/header.jpg");
	background-color: #44324a;
	opacity: 0.7;
}

.forward {
	opacity: 0.0;
}

.backward {
	opacity: 0.0;
}

.carousel {
	background-color: #5d4f7100;
}

#keyword, #search {
	padding-bottom: 10px;
	padding-top: 10px;
}

#search {
	background: #605b7b;
}

body{
	background-color: #5d4f7166;
}

#searchKeyword {
	border-radius: 30px;
	width: 400px;
	height: 50px;
	padding: 1em 1em 1em 2.5em;
}
</style>
 
 
</head>

<body class="no-sidebar">

		<div id="page-wrapper">

			<div id="header">
				<div class="inner">
					<header>
						<h1><a href="../index.jsp" id="logo">나들이 정보</a></h1>
					</header>
				</div>
						
				<jsp:include page="/layout/toolbar.jsp" />
			</div>
		
			<div style="overflow: hidden; padding-top: 30px;">
          		<form class="search" style="float: right">
					<span class="fas fa-search" style="position: relative; margin-right: -40px;"></span>
					<input type="text" name="keyword" id="searchKeyword" value="" style="width: 100%"/>
					<input type="hidden" name="pageNo" value="" />
					<input type="hidden" name="areaCode" value="${areaCode}"/>
		      		<input type="hidden" name="localName" value="${localName}"/>
				</form>
        	</div>
			
			<section class="carousel">
				<div class="reel" style="overflow: visible; transform: translate(0px, 0px);">
					
					<article class="">
						<a href="#" class="image featured"><img name = "museum" src="../resources/images/tripIcon/gyeongbok-palace-3077864_1920.jpg" alt="" style="height: 250.42px;"></a>
						<header>
							<h3><a href="#">박물관</a></h3>
						</header>
						<p>휴식과 배움을 동시에</p>
					</article>

					<article class="">
						<a href="#" class="image featured"><img name = "exhibition" src="../resources/images/tripIcon/snow-708859_1920.jpg	" alt="" style="height: 250.42px;"></a>
						<header>
							<h3><a href="#">전시관</a></h3>
						</header>
						<p>새로운 것을 보고 싶다면</p>
					</article>

					<article class="">
						<a href="#" class="image featured"><img name = "gallery" src="../resources/images/tripIcon/pohang-1613923_1920_eidt.jpg" alt="" style="height: 250.42px;"></a>
						<header>
							<h3><a href="#">미술관</a></h3>
						</header>
						<p>섬세하고 감각적이라면</p>
					</article>

					<article class="">
						<a href="#" class="image featured"><img name = "experience" src="../resources/images/tripIcon/art-1837073_1920.jpg" alt="" style="height: 250.42px;"></a>
						<header>
							<h3><a href="#">체험관</a></h3>
						</header>
						<p>보는 게 다 가 아니다</p>
					</article>

					<article class="">
						<a href="#" class="image featured"><img name = "tradition" src="../resources/images/tripIcon/republic-of-korea-2675868_1920.jpg" alt="" style="height: 250.42px;"></a>
						<header>
							<h3><a href="#">민속마을</a></h3>
						</header>
						<p>그 속에서 살아가리</p>
					</article>

				</div>
				<span class="forward" style="display: block;"></span>
				<span class="backward" style="display: block;"></span>
			</section>
			
				<div class="wrapper style2">

					<article id="main" class="container special">
					<h3><a href="#">이런 곳은 어때요?</a></h3>
						<a href="#" class="image featured"><img src="${trip.firstimage2}" alt="" /></a>
						<header>
							<h2><a href="#">${trip.title}</a></h2>
							
						</header>
						<p>
							${fee.overview}
						</p>
						<footer>
						</footer>
					</article>

				</div>
			
			
		</div>
		
		<script src="../resources/helios/assets/js/jquery.min.js"></script>
		<script src="../resources/helios/assets/js/jquery.dropotron.min.js"></script>
		<script src="../resources/helios/assets/js/jquery.scrolly.min.js"></script>
		<script src="../resources/helios/assets/js/jquery.onvisible.min.js"></script>
		<script src="../resources/helios/assets/js/skel.min.js"></script>
		<script src="../resources/helios/assets/js/util.js"></script>
		<script src="../resources/helios/assets/js/main.js"></script>
		

</body>

</html>