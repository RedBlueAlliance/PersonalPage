<%@ page contentType="text/html;charset=utf-8" %>
<jsp:useBean id="suser" class="com.register.SUser" scope="session"/>
<%
String path = request.getContextPath();
//String imgUrl = (String)request.getSession().getAttribute("upicture");  
System.out.println(path);

%>
<html lang="zh-CN">
<head>
<title>个人主页</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script>
	//String imgUrl =request.getContextPath()+"/"+request.getSession().getAttribute("upicture");
	//var upicture=document.getElementById("upicture").value;
	window.onload=function(){
	var upicture=document.getElementById("upicture").value;
	alert(upicture);
	var path ="<%=path%>";
	//alert(upicture);
	if(upicture!="null"){
		var imgUrl=path+upicture;
		alert(imgUrl);
	//alert(imgUrl);
	var img =document.getElementById('imghead');
	img.setAttribute('src',imgUrl);
	}


	 //System.out.println("1111111111111111");
	 };
	 
	//System.out.println(imgUrl);
	// 选择图片显示
	function imgChange(obj) {
	//获取点击的文本框
	var file =document.getElementById("file");
	var imgUrl =window.URL.createObjectURL(file.files[0]);
	var img =document.getElementById('imghead');
	img.setAttribute('src',imgUrl); // 修改img标签src属性值
	};
</script>
</head>
<body>
	<div class="container">
	<div class="header">
		<div class="login_picture"><img src="login.jpg"></div>

		<div class="denglu">
			 <h5 align="center">欢迎</h5>
			 <h3 align="center"><jsp:getProperty name="suser" property="userid"/></h3>
			 <h5 align="center">登陆个人主页</h5>
		</div>

				<div class="title"><h1>个人网页</h1>
		</div>
	</div>
	<div class="clearfloat"></div>

	<div class="nav">
<div style="position: relative;float: right;">
	<table>
		<tr>
			<td><a href="showinfor.jsp">查看信息</a></td>
			<td><a href="editinfor.jsp">编辑信息</a></td>
			<td><a href="index.jsp">退出</a></td>
		</tr>
	</table>
</div>		
<div class="search">
  <form>
    <input type="text" value="输入搜索的名字" onfocus="this.value = '';" >
    <input type="submit"  value="搜索"/>
  </form>
</div>

	</div>
	<div class="clearfloat"></div>

    <div class="maincontent">
    <div class="sidebar">
        <div class="information">
        	<h1><jsp:getProperty name="suser" property="uname"/></h1>
         <div class="head_picture">
         <img id="imghead" src="avt.png" alt=""/></div>
         <div class="upload_picture">
         	<input id="upicture" type="text" name="upicture" value="<jsp:getProperty name="suser" property="upicture"/>" style="width:150px; display:none" readonly="readonly">
			<form action="uploadservlet" method="post" enctype="multipart/form-data">
			<input id="userid" type="text" name="userid" value="<jsp:getProperty name="suser" property="userid"/>" style="width:150px; display:none" readonly="readonly">
         	<input id="upass" type="text" name="upass" value="<jsp:getProperty name="suser" property="upass"/>" style="width:150px; display:none" readonly="readonly">
         				<input type="file" id="file" name="file" accept="image/*" onchange="imgChange(this);">
         				<input type="submit" name="submit" value="上传">
         	</form>
		</div>
        <div class="details">
             <h3>电话</h3>
             <p><jsp:getProperty name="suser" property="uphone"/></p>      
             <h3>邮箱</h3>
             <p><jsp:getProperty name="suser" property="uemail"/></p>        
        </div>
        </div>
    </div>
             <div class="content">
       <div class="resume">
             <h3 class="part1">个人简历</h3>
             <div class="resume_info">
                  <p><jsp:getProperty name="suser" property="uresume"/></p>
             </div>
         </div>
         <div class="learning">
             <h3 class="part2">学习经历</h3>
             <div class="learning_info">
                  <p><jsp:getProperty name="suser" property="ulearning"/></p>
             </div>
         </div>
         <div class="working">
             <h3 class="part3">工作经历</h3>
             <div class="working_info">
                  <p><jsp:getProperty name="suser" property="uworking"/></p>
             </div>
         </div>
       <div class="awards">
             <h3 class="part4">获奖情况</h3>
             <div class="awards_info">
                  <p><jsp:getProperty name="suser" property="uawards"/></p>
             </div>
         </div>
         <div class="others">
             <h3 class="part5">其他</h3>
             <div class="others_info">
                  <p><jsp:getProperty name="suser" property="uother"/></p>
             </div>
         </div>
     </div>
        
    </div>




    <div class="clearfloat"></div>
    <div class="footer">
    	<div class="student">@曾鑫(信安1602  0906160203)</div>
</div>		
	</div>

</body>
</html>