<#include "header.ftl">
<body class="home-template">
<div id="themecover_mobileworking_willsong"></div>
<#include "menu.ftl">

<header id="indexhead_willsong">
    <div id="description_willsong" class="respowidth_willsong">
        <h3>- For everything that is worth writing about in more than 140 characters -</h3>

        <h3>For everything else follow me <a href="https://twitter.com/aruizca" target="_twitter">@aruizca <i class="fa fa-twitter fa-lg"></i></a></h3>
    </div>
</header>

<section id="main_willsong" role="main">
    <div id="articles_willsong" class="respowidth_willsong">
        <#list posts as post>
            <#if (post.status == "published")>
                <article class="article_willsong" role="article" itemscope itemtype="http://schema.org/Article">
                    <div class="postdetails_willsong">
                        <div>
                            <i class="fa fa-clock-o fa-lg fa-fw"></i>
                            <span>
                              <time class="date_willsong" datetime="${post.date?string("dd MMMM yyyy")}"
                                    itemprop="datePublished">${post.date?string("dd MMMM yyyy")}</time>
                            </span>
                        </div>
                        <div>
                            <i class="fa fa-user fa-lg fa-fw"></i>
                            <span>post.author</span>
                        </div>
                        <#--			{{#if tags}}-->
                        <div>
                            <i class="fa fa-tag fa-lg fa-fw"></i>
                            <span>{{tags separator=", "}}</span>
                        </div>
                        <#--			{{/if}}-->
                    </div>
                    <div class="mainright_willsong">
                        <h2 class="posttitle_willsong" itemprop="headline"><a href="${post.uri}" rel="bookmark">${post.title}</a></h2>

                        <div class="lores_postdetails_willsong">
                            <i class="fa fa-clock-o fa-lg fa-fw"></i>

                            <span>
                                <time class="date_willsong" datetime="${post.date?string("dd MMMM yyyy")}"
                                      itemprop="datePublished">${post.date?string("dd MMMM yyyy")}</time>
                            </span>

                            <i class="fa fa-user fa-lg fa-fw"></i>
                            <span>post.author</span>

                            <#--					{{#if tags}}-->
                            <i class="fa fa-tag fa-lg fa-fw"></i>
                            <span>{{tags separator=", "}}</span>
                            <#--					{{/if}}-->
                        </div>

                        <div class="postcontent_willsong">
                            ${post.body?truncate(80)}
                        </div>

                        <a href="${post.uri}" class="readmore_willsong">Read More</a>
                    </div>
                </article>
            </#if>
        </#list>
        <div id="pagination_willsong">
            <p>Older posts are available in the <a href="${content.rootpath}${config.archive_file}">archive</a>.</p>
        </div>
    </div>
</section>

<#include "footer.ftl">

</body>
</html>