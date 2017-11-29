<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

function animate(target, to){
	var timer = setInterval(function(){
		var width = parseInt(target.style.width);
		target.style.width = (width+2)+"px";
		
		if(width > to)
			clearInterval(timer);
	}, 17); 
}

window.addEventListener("load", function(event){
	var widthButton = document.querySelector("#ex1-tool input[value='너비늘리기']");
	var item = document.querySelector("#ex1-box .item1");
	
	widthButton.onclick = function(e){
		//animate(item, 200);
		/* if(timer == null)
		timer = setInterval(function(){
			var width = parseInt(item.style.width);
			item.style.width = (width+2)+"px";
			
			if(width >= 500)
				clearInterval(timer);
		}, 17); */
	};
});

$(function(){
	var widthButton = $("#ex1-tool input[value='너비늘리기']");
	var item = $("#ex1-box .item1");
	
	    widthButton.click(function(e){
		//1.한번에 변화를 주는 방법
		/* item.css({
			width:"200px"
		}); */
		//2.기간을 두고 점진적으로 변화를 주는방법
		item.css({
			width:"200px"
		})
	/* 	item.animate({
			width:"200px"
		},2000,"linear",function(){
			
			alert("ya");
		}); */
	});
});
</script>
<style>
	.item1{
		width:100px; 
		height:100px; 
		background:yellow;
		transition:500ms;
		transition-property:width, opacity;
		transition-delay:1s; 
		transition-timing-function: cubic-bezier(0.250, 0.250, 0.750, 0.750);
		/* transition-duration:
		transition-delay:
		transition-property:
		transition-timing-function: */
	}
	
	/* .item1:hover{
	opacity:0.2;
		width:200px;
		height:200px;
	} */
</style>
</head>
<body>
	<!-- 너비를 변경하는 애니메이션 -->
	<div id="ex1-tool">
		<input type="button" value="너비늘리기"/>
	</div>
	<div id="ex1-box" style="width:500px; height:500px; background:gray;">
	<div class="item1">
	
	</div>
	</div>
	<hr/>
</body>
</html>