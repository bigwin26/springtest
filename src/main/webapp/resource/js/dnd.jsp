<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   #drop-jon{
      width:500px;
      height : 200px;
      border : 1px solid lime;
   }
</style>
<script>
   window.addEventListener("load", function(event){
      var dropJon = document.querySelector("#drop-jon");
      dropJon.addEventListener("dragenter",function(e){
         e.stopPropagation();
         e.preventDefault();
         dropJon.style.background = "pink";
         console.log("enter");
      });
      dropJon.addEventListener("dragover",function(e){
         e.stopPropagation();
         e.preventDefault();
         console.log("over");
      });
      dropJon.addEventListener("dragleave",function(e){
         e.stopPropagation();
         e.preventDefault();
         dropJon.style.background = "white";
         console.log("leave");
      });
      dropJon.addEventListener("drop",function(e){
         e.stopPropagation();
         e.preventDefault();
         console.log("drop");
         
         for(var key in e.dataTransfer.types[0])//drag할 수있는 것이 파일만 가능한 것이 아니다. 링크,텍스트,이미지 등등 
            console.log(key);
         console.log(e.dataTransfer.types[0]);//Files, Text/plas,....
         console.log(typeof e.dataTransfer.types[0]);
         
         //아무것도 안가져오면서 drop가능 - 이 가능성을 대비---> 둘중 하나라도 null값이면 false
          var isValidate = e.dataTransfer 
                        && e.dataTransfer.types
                        &&e.dataTransfer.types[0].indexOf("Files") >=0;
                        //전송
                        //전송된 전송 타입이 Files 이것을 제일 먼저 실행해야하기때문에 >=
                        //전송한 것이 있어야함.ex,Files, text/plan등등 )
                        //&&e.dataTransfer.types[0]=="Files";//전송된 전송 타입이 Files 이것을 제일 먼저 실행해야하기때문에 >=   
         if(!isValidate){//파일 형식이 아니면  //0 ->0번째 인덱스가 존재
            alert("파일 형식이 올바르지 않습니다.");
            return ; 
         }
         var files = e.dataTransfer.files;
         
         //파일 크기로 파일 하나씩 
         var count =files.length;
         if(count > 1){
            alert("파일은 하나씩 전송할 수 있습니다.");
            return;
         }
         
         var size = files.size;
         if(size>300*1024*1024)
            alert("죄송합니다. 파일의 크기를 300MByte를 넘는 파일은 전송할 수 없습니다.");
         //String **
         //key=value && key=value&key=vlaue
         
         var formData = new FormData();
         formData.append("file",files[0]);
         
         var xhr = new XMLHttpRequest();
         xhr.upload.addEventListener("progress", function(evt){
            if(evt.lengthComputable){
               dropJon.textContent = "진척도:"+Math.round(evt.loaded*100/evt.total)+"%";
            }
         })
         
         xhr.addEventListener("load",function(evt){
            //서버에 있는 파일 목록을 다시 가져와서
            // 현재 페이지 목록에 포함시켜야한다.
         });
         xhr.open("POST","../../upload/?${_csrf.parameterName}=${_csrf.token}");
         xhr.send(formData);
         
         
      /*    var formData = new FormData();
         for(var key in ) */
         
         //--------formdata---------------------------------
         //filesize : ....
         //filename : .....
         //body : 0100010101010
         //파트가 나눠져서 보내져야함.
         //--------------------------------------------------
         
      });
   });
   
   
</script>
</head>
<body>
   <div id ="drop-jon">
   
   </div>
</body>
</html>