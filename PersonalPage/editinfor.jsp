<%@ page contentType="text/html;charset=utf-8" %>
<jsp:useBean id="suser" class="com.register.SUser" scope="session"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>修改个人信息</title>
</head>
<body>
<center>
    <h3>修改个人信息</h3>
    <form method="post" action="editservlet">
        <table>
            <tr>
                <td><input id="userid" type="text" name="userid" value="<jsp:getProperty name="suser" property="userid"/>" style="width:150px; display:none" readonly="readonly"></td>
            </tr>
            <tr>
                <td><input id="upass" type="text" name="upass" value="<jsp:getProperty name="suser" property="upass"/>" style="width:150px; display:none" readonly="readonly"></td>
            </tr>
            <tr>
                <td>个人简历</td>
                <td><textarea name="uresume" cols="30" rows="3" style="resize: none;"><jsp:getProperty name="suser" property="uresume"/></textarea></td>
            </tr>
            <tr>
                <td>学习经历</td>
                <td><textarea name="ulearning" cols="30" rows="3" style="resize: none;"><jsp:getProperty name="suser" property="ulearning"/></textarea></td>
            </tr>
            <tr>
                <td>工作经历</td>
                <td><textarea name="uworking" cols="30" rows="3" style="resize: none;"><jsp:getProperty name="suser" property="uworking"/></textarea></td>
            </tr>
            <tr>
                <td>获奖情况</td>
                <td><textarea name="uawards" cols="30" rows="3" style="resize: none;"><jsp:getProperty name="suser" property="uawards"/></textarea></td>
            </tr>
            <tr>
                <td>其他</td>
                <td><textarea name="uother" cols="30" rows="3" style="resize: none;"><jsp:getProperty name="suser" property="uother"/></textarea></td>
            </tr>
            <tr style="height: 70px">
                <td> &nbsp;</td>
                <td align="center"> <input type="submit" value="提交"></td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>
