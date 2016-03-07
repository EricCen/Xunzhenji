
<%@ page import="org.apache.tools.ant.util.DateUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>图文编辑器</title>
    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
    <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
</head>
<body>

<div class="content">
    <div class="cLineB"><h4>编辑文本自定义内容</h4><a href="javascript:history.go(-1);"  class="right btnGrayS vm" style="margin-top:-27px" >返回</a></div>
    <div class="msgWrap">
        <g:form class="form" method="post" action="save" enctype="multipart/form-data">
            <TABLE class="userinfoArea" style=" margin:20px 0 0 0;" border="0" cellSpacing="0" cellPadding="0" width="100%">
                <THEAD>
                <TR>
                    <TH valign="top"><span class="red">*</span><label for="keywords">关键词：</label>
                        <g:hasErrors bean="${text}" field="keywords">
                            <g:eachError bean="${text}" field="keywords">
                                <br/><p style="color: red;"><g:message error="${it}"/></p>
                            </g:eachError>
                        </g:hasErrors>
                    </TH>
                    <TD><input type="text" class="px" id="keywords" value="${text.keywords?.keyword?.join(" ")}" name="keywords" style="width:500px" ><br />
                        多个关键词请用空格格开：例如: 美丽&nbsp;漂亮&nbsp;好看   </TD>
                    <TD>&nbsp;</TD>
                </TR>
                <TR>
                    <TH valign="top">关键词类型：</TH>
                    <TD>
                        <label for="radio2"><input class="radio" id="radio2" type="radio" name="precisions" value="0" ${text.precisions == 0 ? 'checked="checked"' : ""}/> 包含匹配 （当此关键词包含粉丝输入关键词时有效）</label>
                        <br />
                        <label for="radio1"><input id="radio1" class="radio" type="radio" name="precisions" value="1" ${text.precisions == 1 ? 'checked="checked"' : ""} /> 完全匹配 （当此关键词和粉丝输入关键词完全相同时有效）</label>
                    </TD>
                </TR>
                </THEAD>
                <TBODY>
                <input type="hidden" name="id" value="${text.id}" />
                <TR>
                    <TH valign="top"><span class="red">*</span><label for="text">内容或简介：</label>
                        <g:hasErrors bean="${text}" field="text">
                            <g:eachError bean="${text}" field="text">
                                <br/><p style="color: red;"><g:message error="${it}"/></p>
                            </g:eachError>
                        </g:hasErrors>
                    </TH>
                    <TD><textarea  class="px" id="Hfcontent" name="text" style="width:500px; height:150px">${text.text}</textarea><br />请不要多于1000字否则无法发送!


                    </TD>
                    <TD rowspan="2" valign="top"><div style="margin-left:20px" class="zdhuifu">
                        <h4 class="red">文字加超链接范例：</h4>

                        <div> &lt;a&nbsp;href=&quot;http://baidu.com/index.php?ac=cate1&amp;tid=9379&amp;c=fromUsername&quot;&gt;3G首页&lt;/a&gt; </div>
                        <br>
                        效果如下：<br>
                        <asset:image src="chaolianjie.jpg" alt="文字超链接效果" />
                    </div></TD>

                <TR>
                    <TH></TH>
                    <TD><button type="submit"  name="button"  class="btnGreen left" >保存</button>
                        <g:link controller="image" action="add" class="btnGray vm"  >切换到图文模式</g:link> 　
                        <a href="index.php?ac=importtxt&amp;id=9379"  class="btnGray vm">取消</a>
                        <div class="right" style="margin-right:10px"  >
                            <ul>
                                <li class="biaoqing"><span>表情</span>
                                    <ul>
                                        <li><asset:image src="face/0.gif" alt="微笑" onclick="jsbq('微笑')" /></li>
                                        <li><asset:image src="face/0.gif" alt="微笑" onclick="jsbq('微笑')" /></li>
                                        <li><asset:image src="face/1.gif" alt="撇嘴" onclick="jsbq('撇嘴')" /></li>
                                        <li><asset:image src="face/2.gif" alt="色" onclick="jsbq('色')" /></li>
                                        <li><asset:image src="face/3.gif" alt="发呆" onclick="jsbq('发呆')" /></li>
                                        <li><asset:image src="face/4.gif" alt="得意" onclick="jsbq('得意')" /></li>
                                        <li><asset:image src="face/5.gif" alt="流泪" onclick="jsbq('流泪')" /></li>
                                        <li><asset:image src="face/6.gif" alt="害羞" onclick="jsbq('害羞')" /></li>
                                        <li><asset:image src="face/7.gif" alt="闭嘴" onclick="jsbq('闭嘴')" /></li>
                                        <li><asset:image src="face/8.gif" alt="睡" onclick="jsbq('睡')" /></li>
                                        <li><asset:image src="face/9.gif" alt="大哭" onclick="jsbq('大哭')" /></li>
                                        <li><asset:image src="face/10.gif" alt="尴尬" onclick="jsbq('尴尬')" /></li>
                                        <li><asset:image src="face/11.gif" alt="发怒" onclick="jsbq('发怒')" /></li>
                                        <li><asset:image src="face/12.gif" alt="调皮" onclick="jsbq('调皮')" /></li>
                                        <li><asset:image src="face/13.gif" alt="呲牙" onclick="jsbq('呲牙')" /></li>
                                        <li><asset:image src="face/14.gif" alt="惊讶" onclick="jsbq('惊讶')" /></li>
                                        <li><asset:image src="face/15.gif" alt="难过" onclick="jsbq('难过')" /></li>
                                        <li><asset:image src="face/16.gif" alt="酷" onclick="jsbq('酷')" /></li>
                                        <li><asset:image src="face/17.gif" alt="冷汗" onclick="jsbq('冷汗')" /></li>
                                        <li><asset:image src="face/18.gif" alt="抓狂" onclick="jsbq('抓狂')" /></li>
                                        <li><asset:image src="face/19.gif" alt="吐" onclick="jsbq('吐')" /></li>
                                        <li><asset:image src="face/20.gif" alt="偷笑" onclick="jsbq('偷笑')" /></li>
                                        <li><asset:image src="face/21.gif" alt="可爱" onclick="jsbq('可爱')" /></li>
                                        <li><asset:image src="face/22.gif" alt="白眼" onclick="jsbq('白眼')" /></li>
                                        <li><asset:image src="face/23.gif" alt="傲慢" onclick="jsbq('傲慢')" /></li>
                                        <li><asset:image src="face/24.gif" alt="饥饿" onclick="jsbq('饥饿')" /></li>
                                        <li><asset:image src="face/25.gif" alt="困" onclick="jsbq('困')" /></li>
                                        <li><asset:image src="face/26.gif" alt="惊恐" onclick="jsbq('惊恐')" /></li>
                                        <li><asset:image src="face/27.gif" alt="流汗" onclick="jsbq('流汗')" /></li>
                                        <li><asset:image src="face/28.gif" alt="憨笑" onclick="jsbq('憨笑')" /></li>
                                        <li><asset:image src="face/29.gif" alt="大兵" onclick="jsbq('大兵')" /></li>
                                        <li><asset:image src="face/30.gif" alt="奋斗" onclick="jsbq('奋斗')" /></li>
                                        <li><asset:image src="face/31.gif" alt="咒骂" onclick="jsbq('咒骂')" /></li>
                                        <li><asset:image src="face/32.gif" alt="疑问" onclick="jsbq('疑问')" /></li>
                                        <li><asset:image src="face/33.gif" alt="嘘" onclick="jsbq('嘘')" /></li>
                                        <li><asset:image src="face/34.gif" alt="晕" onclick="jsbq('晕')" /></li>
                                        <li><asset:image src="face/35.gif" alt="折磨" onclick="jsbq('折磨')" /></li>
                                        <li><asset:image src="face/36.gif" alt="衰" onclick="jsbq('衰')" /></li>
                                        <li><asset:image src="face/37.gif" alt="骷髅" onclick="jsbq('骷髅')" /></li>
                                        <li><asset:image src="face/38.gif" alt="敲打" onclick="jsbq('敲打')" /></li>
                                        <li><asset:image src="face/39.gif" alt="再见" onclick="jsbq('再见')" /></li>
                                        <li><asset:image src="face/40.gif" alt="擦汗" onclick="jsbq('擦汗')" /></li>
                                        <li><asset:image src="face/41.gif" alt="抠鼻" onclick="jsbq('抠鼻')" /></li>
                                        <li><asset:image src="face/42.gif" alt="鼓掌" onclick="jsbq('鼓掌')" /></li>
                                        <li><asset:image src="face/43.gif" alt="糗大了" onclick="jsbq('糗大了')" /></li>
                                        <li><asset:image src="face/44.gif" alt="坏笑" onclick="jsbq('坏笑')" /></li>
                                        <li><asset:image src="face/45.gif" alt="左哼哼" onclick="jsbq('左哼哼')" /></li>
                                        <li><asset:image src="face/46.gif" alt="右哼哼" onclick="jsbq('右哼哼')" /></li>
                                        <li><asset:image src="face/47.gif" alt="哈欠" onclick="jsbq('哈欠')" /></li>
                                        <li><asset:image src="face/48.gif" alt="鄙视" onclick="jsbq('鄙视')" /></li>
                                        <li><asset:image src="face/49.gif" alt="委屈" onclick="jsbq('委屈')" /></li>
                                        <li><asset:image src="face/50.gif" alt="快哭了" onclick="jsbq('快哭了')" /></li>
                                        <li><asset:image src="face/51.gif" alt="阴险" onclick="jsbq('阴险')" /></li>
                                        <li><asset:image src="face/52.gif" alt="亲亲" onclick="jsbq('亲亲')" /></li>
                                        <li><asset:image src="face/53.gif" alt="吓" onclick="jsbq('吓')" /></li>
                                        <li><asset:image src="face/54.gif" alt="可怜" onclick="jsbq('可怜')" /></li>
                                        <li><asset:image src="face/55.gif" alt="菜刀" onclick="jsbq('菜刀')" /></li>
                                        <li><asset:image src="face/56.gif" alt="西瓜" onclick="jsbq('西瓜')" /></li>
                                        <li><asset:image src="face/57.gif" alt="啤酒" onclick="jsbq('啤酒')" /></li>
                                        <li><asset:image src="face/58.gif" alt="篮球" onclick="jsbq('篮球')" /></li>
                                        <li><asset:image src="face/59.gif" alt="乒乓" onclick="jsbq('乒乓')" /></li>
                                        <li><asset:image src="face/60.gif" alt="咖啡" onclick="jsbq('咖啡')" /></li>
                                        <li><asset:image src="face/61.gif" alt="饭" onclick="jsbq('饭')" /></li>
                                        <li><asset:image src="face/62.gif" alt="猪头" onclick="jsbq('猪头')" /></li>
                                        <li><asset:image src="face/63.gif" alt="玫瑰" onclick="jsbq('玫瑰')" /></li>
                                        <li><asset:image src="face/64.gif" alt="凋谢" onclick="jsbq('凋谢')" /></li>
                                        <li><asset:image src="face/65.gif" alt="示爱" onclick="jsbq('示爱')" /></li>
                                        <li><asset:image src="face/66.gif" alt="爱心" onclick="jsbq('爱心')" /></li>
                                        <li><asset:image src="face/67.gif" alt="心碎" onclick="jsbq('心碎')" /></li>
                                        <li><asset:image src="face/68.gif" alt="蛋糕" onclick="jsbq('蛋糕')" /></li>
                                        <li><asset:image src="face/69.gif" alt="闪电" onclick="jsbq('闪电')" /></li>
                                        <li><asset:image src="face/70.gif" alt="炸弹" onclick="jsbq('炸弹')" /></li>
                                        <li><asset:image src="face/71.gif" alt="刀" onclick="jsbq('刀')" /></li>
                                        <li><asset:image src="face/72.gif" alt="足球" onclick="jsbq('足球')" /></li>
                                        <li><asset:image src="face/73.gif" alt="瓢虫" onclick="jsbq('瓢虫')" /></li>
                                        <li><asset:image src="face/74.gif" alt="便便" onclick="jsbq('便便')" /></li>
                                        <li><asset:image src="face/75.gif" alt="月亮" onclick="jsbq('月亮')" /></li>
                                        <li><asset:image src="face/76.gif" alt="太阳" onclick="jsbq('太阳')" /></li>
                                        <li><asset:image src="face/77.gif" alt="礼物" onclick="jsbq('礼物')" /></li>
                                        <li><asset:image src="face/78.gif" alt="拥抱" onclick="jsbq('拥抱')" /></li>
                                        <li><asset:image src="face/79.gif" alt="强" onclick="jsbq('强')" /></li>
                                        <li><asset:image src="face/80.gif" alt="弱" onclick="jsbq('弱')" /></li>
                                        <li><asset:image src="face/81.gif" alt="握手" onclick="jsbq('握手')" /></li>
                                        <li><asset:image src="face/82.gif" alt="胜利" onclick="jsbq('胜利')" /></li>
                                        <li><asset:image src="face/83.gif" alt="抱拳" onclick="jsbq('抱拳')" /></li>
                                        <li><asset:image src="face/84.gif" alt="勾引" onclick="jsbq('勾引')" /></li>
                                        <li><asset:image src="face/85.gif" alt="拳头" onclick="jsbq('拳头')" /></li>
                                        <li><asset:image src="face/86.gif" alt="差劲" onclick="jsbq('差劲')" /></li>
                                        <li><asset:image src="face/87.gif" alt="爱你" onclick="jsbq('爱你')" /></li>
                                        <li><asset:image src="face/88.gif" alt="NO" onclick="jsbq('NO')" /></li>
                                        <li><asset:image src="face/89.gif" alt="OK" onclick="jsbq('OK')" /></li>
                                        <li><asset:image src="face/90.gif" alt="爱情" onclick="jsbq('爱情')" /></li>
                                        <li><asset:image src="face/91.gif" alt="飞吻" onclick="jsbq('飞吻')" /></li>
                                        <li><asset:image src="face/92.gif" alt="跳跳" onclick="jsbq('跳跳')" /></li>
                                        <li><asset:image src="face/93.gif" alt="发抖" onclick="jsbq('发抖')" /></li>
                                        <li><asset:image src="face/94.gif" alt="怄火" onclick="jsbq('怄火')" /></li>
                                        <li><asset:image src="face/95.gif" alt="转圈" onclick="jsbq('转圈')" /></li>
                                        <li><asset:image src="face/96.gif" alt="磕头" onclick="jsbq('磕头')" /></li>
                                        <li><asset:image src="face/97.gif" alt="回头" onclick="jsbq('回头')" /></li>
                                        <li><asset:image src="face/98.gif" alt="跳绳" onclick="jsbq('跳绳')" /></li>
                                        <li><asset:image src="face/99.gif" alt="挥手" onclick="jsbq('挥手')" /></li>
                                        <li><asset:image src="face/100.gif" alt="激动" onclick="jsbq('激动')" /></li>
                                        <li><asset:image src="face/101.gif" alt="街舞" onclick="jsbq('街舞')" /></li>
                                        <li><asset:image src="face/102.gif" alt="献吻" onclick="jsbq('献吻')" /></li>
                                        <li><asset:image src="face/103.gif" alt="左太极" onclick="jsbq('左太极')" /></li>
                                    </ul>
                                </li>
                            </ul>
                        </div><div class="clr"></div>
                        <script type="text/javascript">
                            function jsbq(srt){
                                document.getElementById("Hfcontent").value=document.getElementById("Hfcontent").value+"/"+srt;
                            }
                        </script></TD>
                </TR>
                </TBODY>
            </TABLE>
        </g:form>



    </div>

</div>

<div class="clr"></div>

</body>
</html>