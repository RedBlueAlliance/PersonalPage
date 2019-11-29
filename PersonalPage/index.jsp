<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<title>个人主页</title>
<link href="style.css" rel="stylesheet" type="text/css" />
    <script>
        function checkdata()
        {
            var uname=document.loginform.uname.value;
            if(uname=="")
            {
                alert("用户名不能为空，必须输入");
                document.loginform.uname.focus();
                return false;
            }
            var upass=document.loginform.upass.value;
            if(upass==""){
                alert("密码不能为空，必须输入！");
                document.loginform.upass.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
	<div class="container">
	<div class="header">
		<div class="login_picture"><img src="login.jpg" alt=""></div>
		<div class="denglu">
		<h3>用户登录</h3>
		<form name="loginform" method="post" action="loginservlet">
        <table>
            <tr>
                <td>用户名</td>
                <td> <input type="text" name="userid" style="width:150px" ></td>
            </tr>
            <tr>
                <td> 密码</td>
                <td> <input type="password" name="upass" style="width:150px"> </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td> <input type="submit" name="login" value="登录" onclick="return checkdata()">
                    <input type="reset" name="reset" value="重置">
                    <a href="register.jsp" >注册</a>
                </td>
            </tr>
        </table>
    </form>
		</div>
			<div class="title"><h1>个人网页</h1>
		</div>
	</div>
	<div class="clearfloat"></div>
	<div class="nav">
		<div class="search">
  <form name="searchform" method="post" action="searchservlet">
    <input type="text" value="输入搜索的用户ID" name="userid" onfocus="this.value = '';" >
    <input type="submit"  value="搜索"/>
  </form>
</div>
	</div>
	<div class="clearfloat"></div>

    <div class="maincontent">
    <div class="sidebar">
        <div class="information">
        	<h1>用户名</h1>
         <div class="head_picture">
         <img src="avt.png" alt=""></div>
         <div class="upload_picture"></div>
        <div class="details">
             <h3>电话</h3>
             <p></p>      
             <h3>邮箱</h3>
             <p></p>         
        </div>
        <div class="submit_info"></div>
        </div>
    </div>
             <div class="content">
       <div class="resume">
             <h3 class="part1">个人简历</h3>
             <div class="resume_info">
                  <p></p>
             </div>
         </div>
         <div class="learning">
             <h3 class="part2">学习经历</h3>
             <div class="learning_info">
                  <p></p>
             </div>
         </div>
         <div class="working">
             <h3 class="part3">工作经历</h3>
             <div class="working_info">
                  <p></p>
             </div>
         </div>
       <div class="awards">
             <h3 class="part4">获奖情况</h3>
             <div class="awards_info">
                  <p></p>
             </div>
         </div>
         <div class="others">
             <h3 class="part5">其他</h3>
             <div class="others_info">
                  <p></p>
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
