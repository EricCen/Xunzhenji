<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>分组管理</title>
    <asset:stylesheet href="cymain.css" />
</head>
<body>
<div class="content">
    <div class="cLineB"><h4>设置粉丝分组</h4><a href="javascript:history.go(-1);"  class="right btnGrayS vm" style="margin-top:-27px" >返回</a></div>

    <g:form method="post" action="save" enctype="multipart/form-data">
        <div class="msgWrap form">
            <TABLE class="userinfoArea" border="0" cellSpacing="0" cellPadding="0" width="100%">
                <TR>
                    <TH valign="top"><label for="pic">名称：</label></TH>
                    <TD><input class="px" name="name" id="name" value="${weChatGroup?.name}" style="width:200px;"/>
                    </TD>
                </TR>
                <TR>
                    <TH valign="top"><label for="info">简介：</label></TH>
                    <TD><textarea name="description" id="description" class="px" rows="5"
                                  style="width:490px;height:80px">${weChatGroup?.description}</textarea></TD>
                </TR>

                <TR>
                    <TH></TH>
                    <TD><input type="hidden" name="id" value="${weChatGroup?.id}"/>
                    <input type="submit" value="保存" name="sbmt" class="btnGreen left"></TD>
                </TR>
            </TBODY>
            </TABLE>

        </div>
    </g:form>
          
    </div>
 
    <div class="clr"></div>
</body>
</html>