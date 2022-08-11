<#include "header.ftl">
<body class="home-template">
<div id="themecover_mobileworking_willsong"></div>
<#include "menu.ftl">

<#include "common-heading.ftl">

<section id="main_willsong" role="main">
    <div id="articles_willsong" class="respowidth_willsong">
        <#list posts as post>
            <#if (post.status == "published"  && post?index >= (currentPageNumber-1) * config.index_posts_per_page?eval && post?index < currentPageNumber * config.index_posts_per_page?eval)>
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
                        <#if post.tags?size != 0>
                            <div>
                                <i class="fa fa-tag fa-lg fa-fw"></i>
                                <span>${post.tags?join(", ")}</span>
                            </div>
                        </#if>
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
                            <span>${post.author}</span>

                            <#if post.tags?size != 0>
                                <i class="fa fa-tag fa-lg fa-fw"></i>
                                <span>${post.tags?join(", ")}</span>
                            </#if>
                        </div>

                        <div class="postcontent_willsong">
                            ${post.body?truncate(400, '')}
                        </div>

                        <a href="${post.uri}" class="readmore_willsong">Read More</a>
                    </div>
                </article>
            </#if>
        </#list>
        <div id="pagination_willsong">
            <ul class="pager">
                <#if (currentPageNumber > 1)>
                    <li>
                        <a href="${config.site_host}/${(currentPageNumber==2)?then('', currentPageNumber-1)}">
                            <i class="fa fa-arrow-left fa-lg fa-fw"></i>
                        </a>
                    </li>
                </#if>
                <li class="page-index">Page: ${currentPageNumber}/${numberOfPages}</li>
                <#if (currentPageNumber < numberOfPages)>
                    <li>
                        <a href="${config.site_host}/${currentPageNumber + 1}">
                            <i class="fa fa-arrow-right fa-lg fa-fw"></i>
                        </a>
                    </li>
                </#if>
            </ul>
        </div>
    </div>
</section>

<#include "footer.ftl">

</body>
</html>