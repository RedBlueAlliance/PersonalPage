[TOC]

## 个人主页展示

1. 初始页面，点击注册，也可以登陆，也可以直接搜索用户信息  

      ![初始页面]( https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161403802.png?raw=true)

      

1. 注册，填写信息，有每项的验证，就不一一截图了，实现手机验证码

   ![注册](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161623846.png?raw=true)

2. 注册成功或者登陆成功的页面

   ![登陆成功的页面](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161650281.png?raw=true)

3. 可上传图片

   ![上传图片](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161718118.png?raw=true)

4. 上传成功

   ![图片上传成功](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161739032.png?raw=true)

5. 点击编辑信息，可以对下面的内容进行编辑

   ![修改个人信息](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161800119.png?raw=true)

6. 编辑成功后的页面

   ![编辑成功](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161819478.png?raw=true)

7. 游客可以搜索用户信息

   ![游客页面](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129161833297.png?raw=true)





## 如何搭建环境

1. 本地搭建服务器环境：apache-tomcat 

   将PersonalPage文件夹复制到webapps目录下 

![搭建环境](https://github.com/RedBlueAlliance/PersonalPage/blob/master/images/image-20191129162044109.png?raw=true)

2. 安装数据库MySQL

   安装MySQL数据库，网上教程很多，自行安装。

   创建一个名为personalpage的数据库，并创建一张名为personalinfor的表，对其表内容字段进行设置，用于存储信息。

   **字段信息**

   |          | **Field** | **Type**     | **Comment** |
   | -------- | --------- | ------------ | ----------- |
   | **主键** | userid    | varchar(15)  | 用户名      |
   |          | uname     | varchar(20)  | 真实姓名    |
   | **主键** | upass     | varchar(20)  | 密码        |
   |          | usex      | char(2)      | 性别        |
   |          | uage      | int(10)      | 年龄        |
   |          | uemail    | varchar(30)  | 邮箱        |
   |          | uphone    | varchar(15)  | 手机        |
   |          | uresume   | varchar(600) | 个人简介    |
   |          | ulearning | varchar(600) | 学习经历    |
   |          | uworking  | varchar(600) | 工作经历    |
   |          | uawards   | varchar(600) | 获奖情况    |
   |          | uother    | varchar(600) | 其他        |
   |          | upicture  | varchar(600) | 图片        |

    

   **索引信息**

   |          | **Indexes** | **Columns**   | **Index_Type** |
   | -------- | ----------- | ------------- | -------------- |
   | **主键** | PRIMARY     | userid, upass | Unique         |

    

   **DDL信息**

    ~~~mysql
   CREATE TABLE `personalinfor` (
      `userid` varchar(15) NOT NULL COMMENT '用户名',
      `uname` varchar(20) DEFAULT NULL COMMENT '真实姓名',
      `upass` varchar(20) NOT NULL COMMENT '密码',
      `usex` char(2) DEFAULT NULL COMMENT '性别',
      `uage` int(10) DEFAULT NULL COMMENT '年龄',
      `uemail` varchar(30) DEFAULT NULL COMMENT '邮箱',
      `uphone` varchar(15) DEFAULT NULL COMMENT '手机',
      `uresume` varchar(600) DEFAULT NULL COMMENT '个人简介',
      `ulearning` varchar(600) DEFAULT NULL COMMENT '学习经历',
      `uworking` varchar(600) DEFAULT NULL COMMENT '工作经历',
      `uawards` varchar(600) DEFAULT NULL COMMENT '获奖情况',
      `uother` varchar(600) DEFAULT NULL COMMENT '其他',
      `upicture` varchar(600) DEFAULT NULL COMMENT '图片',
      PRIMARY KEY (`userid`,`upass`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8
   
    ~~~

   直接运行上面的SQL语句personalinfor表创建成功。

   数据库的用户名和密码在连接数据库时需要进行相应的修改和配置。

   

## 具体代码详解

1. SUser接受全局变量  

   ~~~java
   //SUser
   public class SUser implements Serializable{
   	//私有成员变量
   	private String userid;
   	private String uname;
   	private String upass;
   	private String usex;
   	private int uage;
   	private String uemail;
   	private String uphone;
   	private String uresume;
   	private String ulearning;
   	private String uworking;
   	private String uawards;
   	private String uother;
   	private String upicture;
   
   	public SUser(String userid,String upicture){//还有一堆，主要功能是实例化带有这些成员变量的对象
   		this.userid=userid;
   		this.upicture=upicture;
   		}
   
   	public SUser(){
   	}
   
   	//一组get与set方法，有一堆，方法是相似的，设置或者获取对象成员变量
   	public String getUserid(){
   		return userid;
   		}
   	public void setUserid(String userid){
   		this.userid = userid;
   		}
   
   ~~~

   

2. 注册Ajax检测用户名是否重用

   ~~~java
   （1）JavaScript代码（前端）
   	function userid_check(){//onBlur="userid_check(this)" 对象失去焦点时发生，即当光标在用户ID的输入框时。鼠标点击到其他部位触发该函数
   		var userid=document.getElementById("userid").value;//获取用户ID输入框的值
   		var xhr=Ajax();//建立XMLHttpRequest (XHR)对象，与服务器交互
   		if(userid==""){//判断用户ID是否为空，为空，前端页面提示"用户名不能为空"
   			document.getElementById("userid_notice").innerHTML="用户名不能为空";
   		}else{//不为空，则触发onreadystatechange事件，会返回XMLHttpRequest的状态信息
   		xhr.onreadystatechange=function(){
   			if(xhr.readyState==4){//4:请求已完成，且响应已就绪
   				if(xhr.status==200){//200:"OK"
   					var data=xhr.responseText;//获得后端字符串形式的响应数据。
   					document.getElementById("userid_notice").innerHTML=data;//在前端页面提示传回来的响应信息
   					if(data=="该用户名已存在，不可用"){//这部分是对提交按钮是否可用的检测元素之一
   						flags[0] = false;
   					}else{
   						flags[0] = true;
   					}
   				}
   			}
   		}
   	xhr.open("get","${pageContext.request.contextPath}/checkuseridservlet?userid="+userid,true);//第一个参数method（请求类型get/post）：通过get方法请求；第二个参数url（文件在服务器上的位置）：${pageContext.request.contextPath}获取绝对路径，向服务器下的checkuseridservlet的传递userid，通过这个servlet与后台数据库进行连接判定是否存在一个同名的用户，并返回结果；第三个参数async：布尔值，true表示异步，false表示同步
   		xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");//表示通过页面表单方式提交（json提交方式为："Content-Type", "application/json"）
   		xhr.send();//将请求发送到服务器。
   		allenable();//用于判定提交按钮是否可用的方法
   		}
   	}
   
   ~~~

   ~~~java
   （1）JavaScript代码（前端）
   	function userid_check(){//onBlur="userid_check(this)" 对象失去焦点时发生，即当光标在用户ID的输入框时。鼠标点击到其他部位触发该函数
   		var userid=document.getElementById("userid").value;//获取用户ID输入框的值
   		var xhr=Ajax();//建立XMLHttpRequest (XHR)对象，与服务器交互
   		if(userid==""){//判断用户ID是否为空，为空，前端页面提示"用户名不能为空"
   			document.getElementById("userid_notice").innerHTML="用户名不能为空";
   		}else{//不为空，则触发onreadystatechange事件，会返回XMLHttpRequest的状态信息
   		xhr.onreadystatechange=function(){
   			if(xhr.readyState==4){//4:请求已完成，且响应已就绪
   				if(xhr.status==200){//200:"OK"
   					var data=xhr.responseText;//获得后端字符串形式的响应数据。
   					document.getElementById("userid_notice").innerHTML=data;//在前端页面提示传回来的响应信息
   					if(data=="该用户名已存在，不可用"){//这部分是对提交按钮是否可用的检测元素之一
   						flags[0] = false;
   					}else{
   						flags[0] = true;
   					}
   				}
   			}
   		}
   	xhr.open("get","${pageContext.request.contextPath}/checkuseridservlet?userid="+userid,true);//第一个参数method（请求类型get/post）：通过get方法请求；第二个参数url（文件在服务器上的位置）：${pageContext.request.contextPath}获取绝对路径，向服务器下的checkuseridservlet的传递userid，通过这个servlet与后台数据库进行连接判定是否存在一个同名的用户，并返回结果；第三个参数async：布尔值，true表示异步，false表示同步
   		xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");//表示通过页面表单方式提交（json提交方式为："Content-Type", "application/json"）
   		xhr.send();//将请求发送到服务器。
   		allenable();//用于判定提交按钮是否可用的方法
   		}
   	}
   
   
   ~~~

   ~~~java
   （2）CheckUseridServlet代码（Servlet）
   public class CheckUseridServlet extends HttpServlet {
   	public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
   		doPost(request, response);
   	}
   	
   	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
   		request.setCharacterEncoding("utf-8");//字符编码
   		response.setCharacterEncoding("utf-8");
   		response.setContentType("text/html;charset=utf-8");
   		PrintWriter pw=response.getWriter();//创建该对象用于用于输出字符流数据
   		String userid = new String(request.getParameter("userid").getBytes("ISO-8859-1"),"utf-8") ;//如果出现中文可以使用该方法，因为中文测试时出现了乱码，导致数据库匹配不到
   		DBUser dbuser = new DBUser(this.getServletContext());//实例化服务器全局的储存信息的空间的对象
   		boolean suser = dbuser.checkSUser(userid);//传给后台数据库判定用户ID是否存在，并返回布尔值
   		if(suser){ //向前端输出字符流数据，ID没有重复，返回"用户名可用"，否则返回"用户名不可用"
   			pw.write("用户名可用"); 
   			}else{
   				pw.write("用户名不可用");
   				}
   		}
   }
   
   ~~~

   ~~~java
   （3）DBUser代码（后台数据库处理）
   	private ServletContext application;
   	//定义构造方法,加载驱动程序,接收全局应用对象
   	public DBUser(ServletContext application){
   		try{
   			Class.forName("com.mysql.jdbc.Driver");
   			}catch(ClassNotFoundException e){
   				e.printStackTrace();
   				}catch(Exception e){
   					e.printStackTrace();
   					}
   		this.application=application;
   		}	
   	public boolean checkSUser(String userid){
   		Connection con=null;
   		boolean flag=true;
   		try{
   			//连接字符串
   			String url="jdbc:mysql://localhost:3306/personalpage?characterEncoding=utf-8";
   			con=DriverManager.getConnection(url,"root","0906160203");//连接数据库三个参数，第一个参数是链接数据库的路径，不同的数据库，写法也有所不同；第二个参数是用户名；第三个参数是密码。
   			Statement stmt = con.createStatement();
   			ResultSet result = stmt.executeQuery("select * from personalinfor where userid= '"+userid+"'");//对数据库构造SQL查询userid的数据项，返回结果集ResultSet
   			if(result.next()){
   				flag=false;
   				}
   			}catch(SQLException e){
   				e.printStackTrace();
   				}catch(Exception e){
   					e.printStackTrace();
   					}finally{
   						if(con!=null){
   							try{
   								con.close();
   								}catch(Exception e){
   									e.printStackTrace();
   									}
   							}
   						}
   		return flag;
   		}
   
   ~~~

   ~~~java
   （3）DBUser代码（后台数据库处理）
   			if(result.next()){//将指针移动到当前位置的下一行。ResultSet 指针的初始位置位于第一行之前；第一次调用next()方法将会把第一行设置为当前行；第二次调用next()方法指针移动到第二行，以此类推。当对next()方法调用返回false，说明此时指针位于最后一行之后，如果一开始指针就没有没有下一行可以移动，就直接返回false，即没有找到任何数据项
   				flag=false;//这里的flag是要传回给之前的servlet，初始化为true，若返回true，则该用户ID数据库没有，可以使用，若返回false，则该用户ID在数据库里存在，不能使用
   				}
   			}catch(SQLException e){
   				e.printStackTrace();
   				}catch(Exception e){
   					e.printStackTrace();
   					}finally{
   						if(con!=null){
   							try{
   								con.close();
   								}catch(Exception e){
   									e.printStackTrace();
   									}
   							}
   						}
   		return flag;
   		}
   
   ~~~

   

3. 手机验证码验证

   ~~~java
   （1）JavaScript代码（前端）
   	var sms="";
   	$("#getCode").click(function(){//获取验证码的按钮被点击，触发该事件
   		var uphone=$("#uphone").val();//获取手机号
   		if(uphone!=""){//判定手机号是否为空
   			$.ajax({
   				url:"sendsmsservlet",//发送给sengsmsservlet处理
   				type:"post",//方式post
   				data:{"uphone":uphone},//发送手机号
   				success:function(result){
   					sms=result;//返回sengsmsservlet处理完传回的数据
   				}
   			});
   		}else{
   			$("#uphone_notice").html("请输入手机号");//提示
   			return false;
   		};
   	});
   
   	$("#checkCode").click(function(){//验证按钮被点击，触发该事件
   		var code=$("#Code").val();//获取输入验证码的值
   		if(code==""){//判定
   			$("#Code_notice").html("请输入验证码");//提示
   		}else{
   			if(sms==code){
   				$("#Code_notice").html("验证码正确");
   				flags[7]=true;//用于对提交按钮的是否可用的元素之一
   			}else{
   				$("#Code_notice").html("验证码错误");
   			};
   		};allenable();//用于对提交按钮的是否可用
   	})
   
   ~~~

   ~~~java
   （2）SendSmsServlet代码（Servlet）
   public class SendSmsServlet extends HttpServlet{
   	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
   		doPost(request,response);
   		}
   	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
   		request.setCharacterEncoding("utf-8");//编码
   		String uphone=request.getParameter("uphone");//接受前端发送过来的手机号
   		String code=GetMessageCode.getCode(uphone);//将手机号传给GetMessageCode类中的getCode方法，并返回code，即传回验证码，这个方法是短信平台提供的接口，下面就不贴出来了
   		response.getWriter().print(code);//将验证码传送回到前端
   		}
   	}
   
   ~~~

   ~~~java
   每次发送不同验证码的方法可以使用下面的方法：
   /*获取一条随机验证码*/
   	public static String getRandomString(int length) { //length表示生成字符串的长度  
   	  String base = "0123456789";
   	  Random random = new Random(); 
   	  StringBuffer sb = new StringBuffer(); 
   	  for (int i = 0; i < length; i++) { 
   	      int number = random.nextInt(base.length());
   	      sb.append(base.charAt(number)); 
   	  }
   	  return sb.toString(); 
   	}
   
   ~~~

   

4. 注册表单数据格式的检测

   ~~~java
   （1）JavaScript代码（前端）
   	function enableSubmit(bool){//设置按钮可用和不可用
   	if(bool){
   		document.getElementById("submit").disabled=false;//启用按钮
   		}else{
   			document.getElementById("submit").disabled=true;//禁用按钮
   			}
   	}
   	
   	function allenable(){//对所有表单项返回的布尔值进行判定
   	for(f in flags) {
   		if(!flags[f]) {
   		enableSubmit(false);//返回全为true，传false，即按钮可用
   		return;} 
   		}enableSubmit(true);//否则，传true，按钮不可用
   	}
   	
   	var flags = [false,false,false,false,false,false,false,false];//初始化全为false，即初始化按钮不可用
   	
   	function uname_check(){//对表单中名字的检测，只进行了对有无输入的检测，并没有对其格式、特殊字符等进行检测
   		var uname=document.getElementById("uname").value;
   		if(uname==""){
   			document.getElementById("uname_notice").innerHTML="名字不能为空";
   		}else{
   			document.getElementById("uname_notice").innerHTML="名字可用";
   			flags[1]=true;
   		}allenable();	
   	}
   	
   	function upass_check(){
   		var upass=document.getElementById("upass").value;
   		if(upass==""){
   			document.getElementById("upass_notice").innerHTML="密码不能为空";
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
   		}else{
   		if(upass1!=upass){
   			document.getElementById("upass1_notice").innerHTML="密码不一致";
   		}else{
   			document.getElementById("upass1_notice").innerHTML="密码一致";
   			flags[3]=true;
   		}allenable();
   		}
   	}
   	
   
   ~~~

   ~~~java
   		}else{
   			document.getElementById("uname_notice").innerHTML="名字可用";
   			flags[1]=true;//用于按钮是否可用的元素之一，下面的都是类似的
   		}allenable();//调用对所有表单项返回的布尔值进行判定
   	}
   	
   	function upass_check(){//对表单中密码的检测，只进行了对有无输入的检测，并没有对密码长度和强度进行检测
   		var upass=document.getElementById("upass").value;
   		if(upass==""){
   			document.getElementById("upass_notice").innerHTML="密码不能为空";
   		}else{
   			document.getElementById("upass_notice").innerHTML="密码可用";
   			flags[2]=true;
   		}allenable();	
   	}
   	
   	function upass1_check(){//对表单两次密码输入是否一致的检测
   		var upass=document.getElementById("upass").value;
   		var upass1=document.getElementById("upass1").value;
   		if(upass1==""){
   			document.getElementById("upass1_notice").innerHTML="密码不能为空";
   		}else{
   		if(upass1!=upass){
   			document.getElementById("upass1_notice").innerHTML="密码不一致";
   		}else{
   			document.getElementById("upass1_notice").innerHTML="密码一致";
   			flags[3]=true;
   		}allenable();
   		}
   	}
   
   	function uage_check(){//对表单年龄输入的检测，年龄只能在16至50岁之间
   		var uage=document.getElementById("uage").value;
   		if(uage==""||isNaN(uage)){
   			document.getElementById("uage_notice").innerHTML="年龄必须输入,不能为空,并且只能是数字";
   		}else{
   			if(parseInt(uage)<16||parseInt(uage)>50){
   				document.getElementById("uage_notice").innerHTML="年龄只能在16至50岁之间";
   			}else{
   				document.getElementById("uage_notice").innerHTML="年龄输入正确";
   				flags[4]=true;
   			}
   		}allenable();	
   	}
   	
   	function uemail_check(){//对邮箱格式的检测
   		var uemail=document.getElementById("uemail").value;
   		if(uemail==""){
   			document.getElementById("uemail_notice").innerHTML="邮箱地址必须输入,不能为空";
   		}else{
   			if(uemail.indexOf('@',0)==-1){
   				document.getElementById("uemail_notice").innerHTML="邮箱地址格式有错误,应包含@字符";
   			}else{
   				if(uemail.indexOf('.',0)==-1){
   					document.getElementById("uemail_notice").innerHTML="邮箱地址格式有错误,应包含.字符";
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
   
   
   ~~~

   ~~~java
   					flags[5]=true;
   				}
   			}
   		}allenable();
   	}
   	
   	function uphone_check(){//对手机号格式的检测
   		var uphone=document.getElementById("uphone").value;
   		if(uphone==""){
   			document.getElementById("uphone_notice").innerHTML="手机号必须输入，不能为空";
   		}else{
   			if(uphone.length!=11|| isNumberic(uphone)==false){
   				document.getElementById("uphone_notice").innerHTML="必须是11位数字";
   			}else{
   				document.getElementById("uphone_notice").innerHTML="格式正确";
   				flags[6]=true;
   			}allenable();
   		}
   	}
   
   ~~~

   

5. 连接数据库

   ~~~java 
   添加数据（insert）
   		String url="jdbc:mysql://localhost:3306/personalpage?characterEncoding=utf-8";
   		con=DriverManager.getConnection(url,"root","0906160203");
   		PreparedStatement stmt= con.prepareStatement("insert into personalinfor values(?,?,?,?,?,?,?,null,null,null,null,null,null)");//添加数据必须与数据库表中的元素一致，没有可以传null或者空字符串
   		stmt.setString(1,suser.getUserid());//对应SQL语句中的“？”
   		stmt.setString(2,suser.getUname());
   		stmt.setString(3,suser.getUpass());
   		stmt.setString(4,suser.getUsex());
   		stmt.setInt(5,suser.getUage());
   		stmt.setString(6,suser.getUemail());
   
   ~~~

   ~~~java 
   更新数据（update）
   		String url="jdbc:mysql://localhost:3306/personalpage?characterEncoding=utf-8";
   		con=DriverManager.getConnection(url,"root","0906160203");
   		PreparedStatement stmt= con.prepareStatement("update personalinfor set uresume=?,ulearning=?,uworking=?,uawards=?,uother=? where userid=?");//注意SQL格式，输入正确就好
   		stmt.setString(1,suser.getUresume());
   		stmt.setString(2,suser.getUlearning());
   		stmt.setString(3,suser.getUworking());
   		stmt.setString(4,suser.getUawards());
   		stmt.setString(5,suser.getUother());
   		stmt.setString(6,suser.getUserid());
   
   ~~~

   ~~~java
   查询数据（select）
   			String url="jdbc:mysql://localhost:3306/personalpage?characterEncoding=utf-8";
   			con=DriverManager.getConnection(url,"root","0906160203");
   			Statement stmt = con.createStatement();
   			ResultSet result = stmt.executeQuery("select * from personalinfor where userid= '"+userid+"'and upass= '"+upass+"'");//注意SQL语句查询的格式正确就好
   			if(result.next()){//前面说过了，指针不断向下移，对查询的数据集，一条一条的读取
   				suser=new SUser();
   				suser.setUserid(result.getString("userid"));
   				suser.setUname(result.getString("uname"));
   				suser.setUpass(result.getString("upass"));
   				suser.setUemail(result.getString("uemail"));
   				suser.setUphone(result.getString("uphone"));
   				suser.setUresume(result.getString("uresume"));
   				suser.setUlearning(result.getString("ulearning"));
   				suser.setUworking(result.getString("uworking"));
   				suser.setUawards(result.getString("uawards"));
   				suser.setUother(result.getString("uother"));
   				suser.setUpicture(result.getString("upicture"));
   			}
   
   ~~~

   

6. 上传图片

   ~~~java
   （1）前端上传图片模块的部分
   	<div class="head_picture">
   		<img id="imghead" src="avt.png" alt=""/>
   	</div>
   	<div class="upload_picture">
   		<input id="upicture" type="text" name="upicture" value="<jsp:getProperty name="suser" property="upicture"/>" style="width:150px; display:none" readonly="readonly">
   		<form action="uploadservlet" method="post" enctype="multipart/form-data">//from表单，使用post方法提交给uploadservlet处理，multipart/form-data表示表单数据有多部分构成,既有文本数据,又有文件等二进制数据，要传图片必须需要表示清楚enctype类型为multipart/form-data
   			<input id="userid" type="text" name="userid" value="<jsp:getProperty name="suser" property="userid"/>" style="width:150px; display:none" readonly="readonly">//为了提交表单时向服务器传userid，因为尝试了很多方法传过去都为空，没有userid就没法找到对应的数据项更新当中的内容，而这种方式可以解决，不知道会不会出现数据的安全性问题，下面是一样作用
   			<input id="upass" type="text" name="upass" value="<jsp:getProperty name="suser" property="upass"/>" style="width:150px; display:none" readonly="readonly">
   			<input type="file" id="file" name="file" accept="image/*" onchange="imgChange(this);">
   			<input type="submit" name="submit" value="上传">
   		</form>
   	</div>
   
   ~~~

   ~~~java
   （2）UploadServlet代码（Servlet）
   	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
   		request.setCharacterEncoding("utf-8");
   		String userid="";
   		String upass="";
   		FileItemFactory factory = new DiskFileItemFactory();//创建文件上传处理器
   		ServletFileUpload upload = new ServletFileUpload(factory);//开始解析请求信息
   		List items = null;
   		try {
   		items = upload.parseRequest(request);
   		}catch (FileUploadException e) {
   			e.printStackTrace();
   			} 
   		Iterator iter = items.iterator();
   		while (iter.hasNext()) {//对所有请求信息进行判断
   		FileItem item = (FileItem) iter.next();
   		if (item.isFormField()) {//信息为普通的格式
   			String fieldName = item.getFieldName();
   			String value = item.getString();
   			request.setAttribute(fieldName, value);
   			if(fieldName.equals("userid")){
   				userid=value;//存储前端发送的userid
   			}else{
   				upass=value;//存储前端发送的upass
   			}
   	 	}else {//信息为文件格式
   			String fileName = item.getName();//获取图片名称
   			int index = fileName.lastIndexOf("\\");
   			fileName = fileName.substring(index + 1);
   			request.setAttribute("upicture", fileName);
   			String basePath = request.getRealPath("/images");
   			File file = new File(basePath, fileName);//把图片存储到basePath目录下，即项目根目录的images目录下
   			String upicture="\\images"+"\\"+fileName;//构造图片的相对路径
   			HttpSession session = request.getSession();
   			DBUser dbuser = new DBUser(this.getServletContext());
   			SUser suser = new SUser(userid,upicture);//实例化一个包含用户ID和图片路径的对象
   			boolean flag=dbuser.uploadSUser(suser);//上传图片路径到数据库
   			if(flag){
   				DBUser dbuser1 = new DBUser(this.getServletContext());
   				SUser suser1 = dbuser1.getSUser(userid,upass);//实例化一个新的对象，用于展示全部信息
   				if(suser1!=null){
   					session.setAttribute("suser",suser1);
   					response.sendRedirect("showinfor.jsp");
   				}else{
   					response.sendRedirect("errorpage.jsp");
   				}
   			}else{
   				response.sendRedirect("errorpage.jsp");
   			}
   		try {
   			item.write(file);
   			}catch (Exception e) {
   				e.printStackTrace();
   			}
   		}	}	}	}
   
   ~~~

   ~~~java
   （3）连接数据库上传图片路径
   		String url="jdbc:mysql://localhost:3306/personalpage?characterEncoding=utf-8";
   		con=DriverManager.getConnection(url,"root","0906160203");
   		PreparedStatement stmt= con.prepareStatement("update personalinfor set upicture=? where userid=?");
   		stmt.setString(1,suser.getUpicture());
   		stmt.setString(2,suser.getUserid());
   
   ~~~

   ~~~java
   （4）上传时的图片的显示和从服务器获取的图片显示
   <%
   String path = request.getContextPath();//获取项目的根路径
   %>
   	
   	//从服务器端获取图片显示
   	window.onload=function(){//页面刷新就触发，更新图片
   	var upicture=document.getElementById("upicture").value;//获取服务器的图片的相对路径，是使用了一个id为upicture的标签使用value接受<jsp:getProperty name="suser" property="upicture"/>来获取到的
   	var path ="<%=path%>";
   	if(upicture!="null"){
   		var imgUrl=path+upicture;//完整的从服务器获取图片的路径
   		var img =document.getElementById('imghead');
   		img.setAttribute('src',imgUrl);//修改img标签src属性值
   		}
   	 };
   
   	//选择图片显示，这个是本地显示
   	function imgChange(obj) {//获取点击的文本框
   	var file =document.getElementById("file");
   	var imgUrl =window.URL.createObjectURL(file.files[0]);
   	var img =document.getElementById('imghead');
   	img.setAttribute('src',imgUrl); //修改img标签src属性值
   	};
   
   ~~~

   