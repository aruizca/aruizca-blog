<#include "header.ftl">
	
<#include "menu.ftl">

<#include "common-heading.ftl">

<section id="main_willsong" role="main">
	<article id="thearticle_willsong" class="respowidth_willsong" role="article" itemscope
			 itemtype="http://schema.org/Article">
		<h2 class="posttitle_willsong" itemprop="headline">${content.title}</h2>

		<div class="articledetails_willsong">

			<i class="fa fa-clock-o fa-lg"></i><span><time class="date_willsong" datetime="${content.date?string("dd MMMM yyyy")}" itemprop="datePublished">{{date format='DD MMM YYYY'}}</time></span>
			<i class="fa fa-user fa-lg"></i><span>{{author.name}}</span>
<#--				{{#if tags}}-->
			<i class="fa fa-tag fa-lg"></i><span>{{tags separator=", "}}</span>
<#--				{{/if}}-->
		</div>

		<div class="postcontent_willsong">
			${content.body}
		</div>

		<div id="sharepost_willsong">
			<span>Share this post:</span><br><br>
			<a class="sharelink_willsong" target="_blank"
			   href="http://www.facebook.com/sharer.php?u={{url absolute="true"}}"><i class="fa fa-facebook fa-lg"></i></a>
			<a class="sharelink_willsong" target="_blank"
			   href="http://twitter.com/share?text={{title}}&url={{url absolute="true"}}"><i class="fa fa-twitter fa-lg"></i></a>
			<a class="sharelink_willsong" target="_blank"
			   href="https://plus.google.com/share?url={{url absolute="true"}}"><i class="fa fa-google-plus-square fa-lg"></i></a>
		</div>

		<#include "disqus.ftl">
	</article>
</section>

	
<#include "footer.ftl">