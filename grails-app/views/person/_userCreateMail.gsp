<%@ page contentType="text/html"%>
<p>${person.name}，你好！</p>
<p>     已为您开通中外运需求管理系统账户，请通过以下链接${grailsApplication.config.sys_url}/login/auth登录系统。</p>
<p>用户名：${person.username}  </p>
<p>初始密码：${pw}  </p>

登录后请马上更改密码，谢谢！

<p>此致</p>

<p>该邮件是广州市嵘程信息科技开发的需求管理系统自动发出，请不要回复，谢谢！</p>
