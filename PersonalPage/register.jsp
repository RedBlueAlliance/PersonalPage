<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>用户注册</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script>

</script>

<script src="jquery-1.9.1.min.js" charset="utf-8"></script>

</head>
<body onload="document.registerform.userid.focus()">
<center>
    <h2 align="center">个人页面</h2>
    <h3 align="center"> 填写注册信息</h3>
    <div align="center">
    <form name="registerform" method="post" action="registerservlet">
        <table  style="position: absolute;left:40%">
            <tr>
                <td> 用户名</td> 
                <td> <input id="userid" onBlur="userid_check(this)" type="text" name="userid" style="width:150px"><span id="userid_notice"> *</span></td>
            </tr>
            <tr>
                <td> 真实姓名</td> 
                <td> <input id="uname" onBlur="uname_check(this)" type="text" name="uname" style="width:150px"><span id="uname_notice"> *</span></td>
            </tr>

            <tr>
                <td> 密码</td> <td> 
                <input id="upass" onBlur="upass_check(this)" type="password" name="upass" style="width:150px"><span id=upass_notice> *</span></td>
            </tr>
            <tr>
                <td> 确认密码</td> <td> 
                <input id="upass1" onBlur="upass1_check(this)" type="password" name="upass1" style="width:150px"><span id=upass1_notice> *</span></td>
            </tr>
            <tr>
                <td> 性别</td> <td> 
                <input type="radio" name="usex" value="男" checked> 男<input type="radio" name="usex" value="女"> 女</td>
            </tr>
            <tr>
                <td> 年龄</td> <td> 
                <input id="uage" onBlur="uage_check(this)" type="text" name="uage" style="width:150px"><span id=uage_notice> *</span></td>
            </tr>
            <tr>
                <td> 邮箱</td> <td> 
                <input id="uemail" onBlur="uemail_check(this)" type="text" name="uemail" style="width:150px"><span id=uemail_notice> *</span></td>
            </tr>
            <tr>
                <td> 手机</td> <td> 
                <input id="uphone" onBlur="uphone_check(this)" type="text" name="uphone" style="width:150px"><span id=uphone_notice> *</span></td>
            </tr>
            <tr>
                <td> 验证码</td> <td> 
                <input id="Code" type="text" name="Code" style="width:150px"><span id=Code_notice> *</span></td>
            </tr>
            <tr>
                <td> &nbsp;</td>
                <td align="left"> <button id="getCode" type="button">获取验证码</button>&nbsp;&nbsp;&nbsp;<button id="checkCode" type="button">验证</button></td>
            </tr>
            <tr style="">
                <td> &nbsp;</td>
                <td align="left"> <input id="submit" type="submit" value="提交" disabled="disabled">
                &nbsp;&nbsp;&nbsp;<input type="reset" value="重置"></td>
            </tr>
        </table>
    </form>
    </div>
</center>

<script>
	function enableSubmit(bool){
	if(bool){
		document.getElementById("submit").disabled=false;
		}else{
			document.getElementById("submit").disabled=true;
			}
	}
	
	function allenable(){
	for(f in flags) {
		if(!flags[f]) {
		enableSubmit(false); 
		return;}
		}enableSubmit(true);
	}
	
	
	
	//System.out.println(flags);
	

	var flags = [false,false,false,false,false,false,false,false];
	
	function Ajax(){
		var xmlHttp;
		try{
			xmlHttp=new XMLHttpRequest();
		}catch(e){
			try{
				xmlHttp=new ActiveXObject("Msxm12.XMLHTTP");
			}catch(e){
				try{
					xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
				}catch(e){}
			}
		}
		return xmlHttp;
	}
	
	function userid_check(){
		var userid=document.getElementById("userid").value;
		var xhr=Ajax();
		if(userid==""){
			document.getElementById("userid_notice").innerHTML="用户名不能为空";
			//document.registerform.userid.focus(); 
		}else{
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4){
				if(xhr.status==200){
					var data=xhr.responseText;
					document.getElementById("userid_notice").innerHTML=data;
					if(data=="该用户名已存在，不可用"){ 
						//alert(data);
						flags[0] = false;
					}else{
						//alert(data);
						flags[0] = true;
					}
					
				}
			}
		}
		xhr.open("get","${pageContext.request.contextPath}/checkuseridservlet?userid="+userid,true);
		xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xhr.send();
		allenable();
		}

	}
	
	function uname_check(){
		var uname=document.getElementById("uname").value;
		if(uname==""){
			document.getElementById("uname_notice").innerHTML="名字不能为空";
			//document.registerform.uname.focus(); 
		}else{
			document.getElementById("uname_notice").innerHTML="名字可用";
			flags[1]=true;
		}allenable();	
	}
	
	function upass_check(){
		var upass=document.getElementById("upass").value;
		if(upass==""){
			document.getElementById("upass_notice").innerHTML="密码不能为空";
			//document.registerform.upass.focus(); 
		}else{
			document.getElementById("upass_notice").innerHTML="密码可用";
			flags[2]=true;
		}allenable();	
	}
	
	function upass1_check(){
		var upass=document.getElementById("upass").value;
		var upass1=document.getElementById("upass1").value;
		if(upass1==""){
			document.getElementById("upass1_notice").innerHTML="密码不能为空";
			//document.registerform.upass1.focus(); 
		}else{
		if(upass1!=upass){
			document.getElementById("upass1_notice").innerHTML="密码不一致";
			//document.registerform.upass1.focus(); 
		}else{
			document.getElementById("upass1_notice").innerHTML="密码一致";
			flags[3]=true;
		}allenable();
		}
	}
	
	function uage_check(){
		var uage=document.getElementById("uage").value;
		if(uage==""||isNaN(uage)){
			document.getElementById("uage_notice").innerHTML="年龄必须输入,不能为空,并且只能是数字";
			//document.registerform.uage.focus(); 
		}else{
			if(parseInt(uage)<16||parseInt(uage)>50){
				document.getElementById("uage_notice").innerHTML="年龄只能在16至50岁之间";
				//document.registerform.uage.focus(); 
			}else{
				document.getElementById("uage_notice").innerHTML="年龄输入正确";
				flags[4]=true;
			}
		}allenable();	
	}
	
	function uemail_check(){
		var uemail=document.getElementById("uemail").value;
		if(uemail==""){
			document.getElementById("uemail_notice").innerHTML="邮箱地址必须输入,不能为空";
			//document.registerform.uemail.focus(); 
		}else{
			if(uemail.indexOf('@',0)==-1){
				document.getElementById("uemail_notice").innerHTML="邮箱地址格式有错误,应包含@字符";
				//document.registerform.uemail.focus(); 
			}else{
				if(uemail.indexOf('.',0)==-1){
					document.getElementById("uemail_notice").innerHTML="邮箱地址格式有错误,应包含.字符";
					//document.registerform.uemail.focus(); 
				}else{
					document.getElementById("uemail_notice").innerHTML="邮箱地址格式正确";
					flags[5]=true;
				}
			}
		}allenable();
	}
	
	function uphone_check(){
		var uphone=document.getElementById("uphone").value;
		if(uphone==""){
			document.getElementById("uphone_notice").innerHTML="手机号必须输入，不能为空";
			//document.registerform.uphone.focus(); 
		}else{
			if(uphone.length!=11|| isNumberic(uphone)==false){
				document.getElementById("uphone_notice").innerHTML="必须是11位数字";
				//document.registerform.uphone.focus(); 
			}else{					
				document.getElementById("uphone_notice").innerHTML="格式正确";
				flags[6]=true;			
			}allenable();
		}
	}
	
	function isNumberic(str){
		var len=str.length;
		for(var i=0;i<len;i++){
			if(str.charAt(i)<'0'||str.charAt(i)>'9'){
				return false;
			}
		}return true;
	}
	
	var sms="";
	$("#getCode").click(function(){
	//alert("请输入手机号");
		var uphone=$("#uphone").val();
		if(uphone!=""){
			$.ajax({
				url:"sendsmsservlet",
				type:"post",
				data:{"uphone":uphone},
				success:function(result){
					sms=result;
				}
			});
		}else{
			$("#uphone_notice").html("请输入手机号");
			alert("请输入手机号");
			return false;
		};
	});

	$("#checkCode").click(function(){
		var code=$("#Code").val();
		if(code==""){
			$("#Code_notice").html("请输入验证码");
			alert("请输入验证码");
		}else{
			if(sms==code){
				$("#Code_notice").html("验证码正确");
				alert("验证码正确");
				flags[7]=true;
			}else{
				$("#Code_notice").html("验证码错误");
				alert("验证码错误");
			};
		};allenable();
	});
</script>
</body>
</html>