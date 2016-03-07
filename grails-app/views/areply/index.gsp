<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="layout" content="admin"/>
    <title>关注时自动回复</title>
    <meta http-equiv="MSThemeCompatible" content="Yes" />
</head>

<body>
<div class="content">

    <div class="cLineB">
        <h4>关注时自动回复内容 - 效果和输入关键字自动回复一样</h4>
    </div>
    <div class="zdhuifu">
        <g:form method="post" action="save">
            <input type="hidden" name="wxid" value="gh_858dwjkeww5"  />

            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr><td height="5"></td><td></td></tr>
                <tr>
                    <p>
                        关键词：<input type="input" style="width:100px;" class="px" id="keyword" value="${subscribeReply?.keyword?.keyword}" name="keyword" style="width:500px" ><br/>例：填写"功能",系统会检索包含最近发布的9条信息，若想关注回复回复首页,此项请填写 首页<br/></td>
                </tr>
                <tr>
                    <g height="50">

                        <input type="submit" value="保存"  name="sbmt"   class="btnGreen left"  />
                        <g:link controller="image" action="index" class="btnGray vm">切换到图文模式</g:link>
                        <g:link controller="text" action="index" class="btnGray vm">切换到文本模式</g:link>

                        <script type="text/javascript">
                            function jsbq(srt){
                                document.getElementById("Hfcontent").value=document.getElementById("Hfcontent").value+"/"+srt;
                            }
                        </script>


                    </td><td valign="top">
                </tr>
            </table>
        </g:form>
    </div>
</div>

<div class="clr"></div>
</div>
</div>
</div>
</body>
</html>