<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="id" value="대승"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="border:1px solid #e9e9e9;
				background:orange;
				width:300px;
				height:500px;
				padding:10px;
				">
		<div>
			<input id="con-button" type="button" value="연결"/>
		</div>
		<div style="border:1px solid #a9a9a9a9;
					height:430px;
					background: white;">
		
		<ul id="chat-list">
			<li></li>
		</ul>
		</div>
		<div style="border:1px solid #e9e9e9;
					height:30px;
					background:white;">
			<input id="chat-text" style="width:100%; height:100%;"/>
			<input id="send-button" type="button" value="send"/>
		</div>
	</div>
</body>
<script type="text/javascript">
	window.addEventListener("load", function(event){
		var id = '${id}';
		var chatList = document.querySelector("#chat-list");
		var chatText = document.querySelector("#chat-text");
		var conButton = document.querySelector("#con-button");
		var sendButton = document.querySelector("#send-button");
		var socket = null;
		
		sendButton.onclick = function(){
			var data = {id:id,text:chatText.value};
			socket.send(JSON.stringify(data)); //제이슨 문자열로 변환해주는법
			/* alert(chatText.value); */
		};
		
		
		conButton.addEventListener("click",function(e){
			socket = new WebSocket("ws://localhost/SpringWeb/resource/chat-server");
			//socket = new WebSocket("ws://211.238.142.72/SpringMVC/resource/chat-server"); 
			socket.onopen = function(evt){
				var li = document.createElement("li");
				li.textContent = id+"님이 접속되었습니다";
				
				chatList.appendChild(li);
			};
			socket.onmessage = function(evt){
				var li = document.createElement("li");
				var data = JSON.parse(evt.data);
				li.textContent = data.id+":"+data.text;
				
				chatList.appendChild(li);
			};
			socket.onclose = function(evt){
				li.textContent = "서버와의 연결이 종료되었습니다.";
				chatList.appendChild(li);
			};
		});
	})
</script>
</html>