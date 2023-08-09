<#include "header.ftl">
<body class="home-template">
<div id="themecover_mobileworking_willsong"></div>
<#include "menu.ftl">

<#include "common-heading.ftl">

<section id="main_willsong" role="main">
    <div id="articles_willsong" class="respowidth_willsong">
        <#list posts as post>
            <#assign postUri = post.uri?keep_before("index.html")>
            <#if (currentPageNumber > 1)>
                <#assign postUri = "../" + postUri>
            </#if>
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
                            <span>${post.author}</span>
                        </div>
                        <#if post.tags?size != 0>
                            <div>
                                <i class="fa fa-tag fa-lg fa-fw"></i>
                                <span>${post.tags?join(", ")}</span>
                            </div>
                        </#if>
                    </div>
                    <div class="mainright_willsong">
                        <h2 class="posttitle_willsong" itemprop="headline"><a href="${postUri}" rel="bookmark">${post.title}</a></h2>

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
                            ${post.body?keep_before("<div class=\"index-break\"></div>")}
                        </div>
                        <a href="${postUri}" class="readmore_willsong">Read More</a>
                    </div>
                </article>
            </#if>
        </#list>

        <div id="pagination_willsong">
            <nav class="pagination" role="navigation">
                <#if (currentPageNumber > 1)>
                <a class="newer-posts" href="/${(currentPageNumber==2)?then('', currentPageNumber-1)}">
                    <i class="fa fa-arrow-left fa-lg fa-fw"></i> Newer Posts
                </a>
                </#if>
                <span class="page-number">Page ${currentPageNumber} of ${numberOfPages}</span>
                <#if (currentPageNumber < numberOfPages)>
                <a class="older-posts" href="/${currentPageNumber + 1}">
                    Older Posts <i class="fa fa-arrow-right fa-lg fa-fw"></i>
                </a>
                </#if>
            </nav>
        </div>
    </div>
</section>

<#include "footer.ftl">

</body>
</html>