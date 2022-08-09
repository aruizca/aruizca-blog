<#include "header.ftl">
<body onload="prettyPrint()">
	<div id="wrap">
		<#include "menu.ftl">

		<div class="page-header">
			<h1>Blog</h1>
		</div>
		<#list posts as post>
			<#if (post.status == "published")>
				<a href="${post.uri}"><h1>${post.title}</h1></a>
				<p>${post.date?string("dd MMMM yyyy")}</p>
				<p>${post.body}</p>
			</#if>
		</#list>

		<hr />

		<p>Older posts are available in the <a href="${content.rootpath}${config.archive_file}">archive</a>.</p>
	</div>
	<div id="push"></div>
	</div>

	<#include "footer.ftl">

</body>
</html>