<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<!--  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>-->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
	<!-- tabs -->
	  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
	  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	  
	  <link rel="stylesheet" href="/resources/helios/assets/css/main.css" />
<title>Insert title here</title>
<style type="text/css">
	.button01 {
    	font-size: 14px;
    	padding: 20px 0 18px;
   		font-weight: 700;
   		width: 30%;
   		position: relative;
   		outline: 0;
   		border: 0;
	}
	hr {
    position: relative;
    display: block;
    top: 0;
    margin-bottom: 0;
    height: 0;
    border: 0;
    width: 95%;
    border-top: solid 1px rgba(128, 128, 128, 0.2);
    border-bottom: solid 1px rgba(128, 128, 128, 0.2);
}
</style>
<script type="text/javascript">
	$(function() {
		var currentPage;
		var maxPage;
			$('a.col-xs-4').bind('click', function() {
			$('a.col-xs-4').css("border", "0")
			$('span.button01').css("color", "#5b5b5b")
			$(this).css("border-bottom", "4px solid #FE8A71");
			$(this).children().css("color", "#FE8A71")
			if($(this).children().html() == "좋아요"){
				$.ajax({
					url: "/like/json/listLikeById",
					method: "GET",
					data: {
						"searchKeyword": "${loginUser.userId}"
					},
					headers: {
						"Accept": "application/json"
					},
					success: function(JSONData) {
						currentPage = 1;
						if(JSONData.totalCount%12 == 0){
							maxPage = JSONData.totalCount / 12;
						}else{
							maxPage = Math.floor(JSONData.totalCount / 12)+1;
						}
						var html="";
						console.log(JSONData)
						for(var i=0;i<JSONData.list.length;i++){
							html += '<div class="row">'
								+'<div class="col-xs-2" align="center" style="color: gray;">'
								+'<span>'+JSONData.yearNMonth[i]+'.</span>'
								+'<span style="font-size:25pt; font-weight:700">'+JSONData.day[i]+'</span>'
								+'</div>'
								+'<div class="col-xs-2">'
								+'<img alt="" src="" style="height: 10%; width: 13%;">'
								+'</div>'
								+'<div class="col-xs-8">'
								+'<p id="addedTitle"><span style="font-size: 9pt; font-weight: 900; color: #3b2b48">';
								if(JSONData.title[i] == null){
									html += "삭제된 게시물입니다."	
								}else{
									html += JSONData.title[i]+'<input type="hidden" name="postNo" value="'+JSONData.list[i].postNo+'">'
								}
								html +='</span></p>'
								+'</div>'
								+'</div>'
								+'<hr/>';
						}
						$('#logContainer').html(html);
						$('#logContainer').on('click', 'p#addedTitle', function() {
							var postNo = $($('input[name="postNo"]')[$('p#addedTitle').index(this)]).val();
							if(postNo == null){
								alert("삭제된 게시물입니다.");
							}else{
								if(postNo.indexOf("60") != 0){
									self.location = "/comm/getComm?postNo="+postNo;
								}else{
									self.location = "/group/getGroup?groupNo="+postNo;
								}
							}
						})
					}
				})
			}else if($(this).children().html() == "댓글"){
				$.ajax({
					url: "/common/listCommentById",
					method: "GET",
					data: {
						"searchKeyword": '${loginUser.userId}'
					},
					headers: {
						"Accept": "application/json",
						"Content-Type": "application/json"
					},
					success: function(JSONData) {
						console.log(JSONData)
						currentPage = 1;
						if(JSONData.totalCount%12 == 0){
							maxPage = JSONData.totalCount / 12;
						}else{
							maxPage = (JSONData.totalCount / 12)+1;
						}
						var html = '';
						for(var i=0;i<JSONData.comments.length;i++){
							html += '<div class="row">'
								+'<div class="col-xs-2" align="center" style="color: gray;">'
								+'<span>'+JSONData.yearNMonth[i]+'.</span>'
								+'<span style="font-size:25pt; font-weight:700">'+JSONData.day[i]+'</span>'
								+'</div>'
								+'<div class="col-xs-2">'
								+'<img alt="" src="" style="height: 10%; width: 13%;">'
								+'</div>'
								+'<div class="col-xs-8">'
								+'<p id="addedTitle"><span style="font-size: 9pt; font-weight: 900; color: #3b2b48">';
								if(JSONData.title[i] == null){
									html += "삭제된 게시물입니다."	
								}else{
									html += JSONData.title[i]+'<input type="hidden" name="postNo" value="'+JSONData.comments[i].postNo+'">'
								}
								html +='</span></p>'
								+JSONData.comments[i].text
								+'</div>'
								+'</div>'
								+'<hr/>';
						}
						$('#logContainer').html(html);
						$('#logContainer').on('click', 'p#addedTitle', function() {
							var postNo = $($('input[name="postNo"]')[$('p#addedTitle').index(this)]).val();
							if(postNo == null){
								alert("삭제된 게시물입니다.");
							}else{
								if(postNo.indexOf("60") != 0){
									self.location = "/comm/getComm?postNo="+postNo;
								}else{
									self.location = "/group/getGroup?groupNo="+postNo;
								}
							}
						})
					}
				})
			}else{
				$.ajax({
					url:"/message/json/listMessage/"+'${loginUser.userId}',
					method:"GET",
					dataType:"json",
					headers :{
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},						
					success: function(returnData){
						$("tbody tr").remove();
						var message = returnData.list;
						var tableValue ="";
										
						
						for (var i = 0; i < message.length; i++) {
							tableValue = "<tr class='warning'>"
					          	+"<td><input type='checkbox' name='checkbox' id='checkbox' value='"
					          	+message[i].messageNo+"'></td>"
					          +"<td>"+message[i].senderId+"</td>"
					          +"<td>"+message[i].receiverId+"</td>"
					          +"<td>"+message[i].text+"</td>"
					          +"<td>"+message[i].regDate+"</td>"
					        +"</tr>";
							$("#logContainer").append(tableValue);
					    }
					}
				});
			}
		})
		$(window).scroll(function() {
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
			      if(currentPage < maxPage){
				      currentPage++;
				      var searchKeyword = $('input[name="searchKeyword"]').val();
				      
				}else{
				    return;
				}
			}
		})
	})
	function infinityScroll() {
		
	}
</script>
</head>
<body>
	  <div id="header">
			<div class="inner">
				<header>
					<h1><a href="/index.jsp" id="logo">N A D R I I</a></h1>
				</header>
			</div>	
			<jsp:include page="/layout/toolbar.jsp" />
     </div>
     <div class="container">
     	<div name="userProfile" style="margin: 20px; position: relative; height: auto;">
      		<a><img alt="" src="/resources/images/00742106_105752.jpg" width="10%" style="margin: 10px;"></a>
     		<span style="position:absolute; top: 10%; margin: 10px; font:bold; font-size: 20pt; color: #3b2b48;">
     			<a style="font-weight: 700;">${loginUser.userId}</a>
     			<br/>
     			<span style="font-size: 12pt;">${loginUser.email}</span>
     		</span>
     		<span style="position:absolute; bottom: 10%; margin: 10px; font:bold;"><a style="font-size: 15px;"><span class="glyphicon glyphicon-cog"> 프로필수정</span></a></span>
     	</div>
     	<div style="margin: 20px; position: relative; height: inherit;">
     		<a class="col-xs-4" align="center"><span class="button01" align="center">좋아요</span></a>
     		<a class="col-xs-4" align="center"><span class="button01" align="center">댓글</span></a>
     		<a class="col-xs-4" align="center"><span class="button01" align="center">쪽지</span></a>
     	</div>
     	<div style="background-color: white;" id="logContainer"></div>
     </div>
     <br/>
     <jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>