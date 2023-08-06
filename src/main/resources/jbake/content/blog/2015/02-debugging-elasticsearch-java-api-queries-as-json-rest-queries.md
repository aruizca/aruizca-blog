title=How to reference a file inside a Grails plugin
date=2015-03-25
author=Angel Ruiz
type=post
tags=elasticsearch, java, json, debug
status=published
~~~~~~

<a href="https://www.elastic.co/products/elasticsearch" target="_blank"> 
![elasticsearch-java-json](img/elasticsearch-java-json.png)
</a>

It took me long enough time to find out, so I thought I would make a post for anyone else who is after the answer in the future.

In Groovy code:
```groovy
log.debug("ElasticSearch Query using Java Client API:\n${searchRequestBuilder.internalBuilder()}")
```

And this in Java:
```java
log.debug("ElasticSearch Query using Java Client API:\n" + searchRequestBuilder.internalBuilder());
```

The output is prettified by default.