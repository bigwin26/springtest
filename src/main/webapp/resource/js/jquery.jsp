<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

	/* window.addEventListener("load", function()) */
	$(function(){
		// DOM 객체를
		//var _chButton = document.getElementByID("ch-Button"); // DOM 객체
		// jQuery 객체로 바꾸는 방법1 : jQuery 함수 이용하기
		//var chButton = jQuery(_chButton);

		// jQuery 객체로 바꾸는 방법2 : $ 함수 이용하기
		//var chButton = $(_chButton);

		// jQuery 객체로 바꾸는 방법3 : CSS Selector 이용하기
		$("#ch-button").click(function() {
			/* //스타일 설정. .css(값이한개=getter),(값두개=sertter)
			$("#p").css("background","red"); */
			//여러개 스타일 설정이 필요한경우
			$("#p").css({
				background : "red",
				"font-size" : "23px",
			});
			
		});
	});
	  //--속성변경예제 --
	   $(function() {
	      var container = $("#img-container");   
	      var img = $("img");
	      var imgSrc = $("#img-src");

	      $("#ch-img-button").click(function() {
	    	  img.attr("src",imgSrc.val());
	      });
	   });
	  
	   $(function() {
		   var chNodeButton = $("#ch-node-button");
		   var container = $("#ch-node-container");   
		   chNodeButton.click(function() {
			   //1.텍스트 노드 추가
		      container.text("<h1>testtestset</h1>");
		      //2.엘리먼트 노드 추가
		      //container.html("<h1>testtestset</h1>");
		   });
		});
	   
	   <!--텍스트 노드 추가 예제 -->
	  $(function() {
		   var addTextNodeButton = $("#add-text-node-button");
		   var addImgNodeButton = $("#add-img-node-button");
		   var removeNodeButton = $("#remove-node-button");
		   var container = $("#node-container");   
		   
		   var remove = function(e){
		      //container.removeChild(e.target);
		      container.removeChild(this);
		   }
		   var idx = 0;
		   addTextNodeButton.click(function() {
		      //1.TextNode 생성
		      var span = $('<span/>'); //<>를 안쓰면 SPAN태그를 찾게되는데 <>를 쓰면 SPAN태그를 만들어준다
		      var txt = '안녕하세여'+ idx++;
		      //2. container(부모) 얻기
		      //3. 부모에 자식을 추가
		      span.append(txt);
		      container.append(span);
		      
		      span.click(remove);
		      
		   });
		   addImgNodeButton.click(function() {
		      //How to 1(성능에 좋음)
		      //1 Element 생성
		      //DOM스타일 코드
		      /* var img = $('<img/>');
		      img.attr("src","http://t1.daumcdn.net/thumb/R1024x0/?fname=http://cfile25.uf.tistory.com/image/2239B038579139CF067E3D");
		      //2. container(부모) 얻기
		      //3. 부모에 자식을 추가
		      container.append(img);
		      img.click(remove); */
		      $("<img src='http://t1.daumcdn.net/thumb/R1024x0/?fname=http://cfile25.uf.tistory.com/image/2239B038579139CF067E3D'>")
		      .appendTo(container)
		      .click(remove);
		      
		      //How to 2 (성능에 좋지 않지만 편리함.-> 한두개 넣는 상황의 성능에 영향을 주지 않을 거라면 이를 사용)
		      //container.html('<img onClick="remove()" src="http://t1.daumcdn.net/thumb/R1024x0/?fname=http://cfile1.uf.tistory.com/image/2134514F579B4C7D165741" />');
		      
		      
		   });
		   removeNodeButton.click(function() {
		      // 1. 내정된 노드를 지우기
		      if(container.hasChildNodes()){
		         container.removeChild(container.lastChild);
		      }
		      // 2. 선택된 노드를 지우기
		      
		   });
		});
</script>
</head>
<body>
<!--텍스트 노드 추가 예제 -->
   <input id="add-text-node-button" type="button" value="텍스트노드 추가" />
   <input id="add-img-node-button" type="button" value="이미지노드 추가?" />
   <input id="remove-node-button" type="button" value="노드 삭제" />
   <div id="node-container"></div>
   <hr />
<!--자식노드변경예제 -->
   <input id="ch-node-button" type="button" value="자식노드 변경" />
   <div id="ch-node-container">hello</div>
   <hr />
 <hr />
   <!--속성변경예제 -->
   <input type="text" id="img-src" />
   <input id="ch-img-button" type="button" value="이미지 변경" />
   <div id="img-container">
      <img src="http://i.huffpost.com/gen/5524070/thumbs/o-THE-570.jpg?3" />
   </div>
   <hr />
<hr />
   <!-- 노드 순회 예제------------------------------------------------------------------------------------ -->
   <input id="ch-button" type="button" value="배경색 변경"/>
   <div>
      <div>1</div>
      <div id="p">
         <div>2</div>
         <!-- comment -->
      </div>
      <div>3</div>
   </div>
   <hr />
</body>
</html>