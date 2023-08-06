title=How to render JSON properly (without escaping quotes) inside a GSP script tag
date=2014-11-19
author=Angel Ruiz
type=post
tags=grails, how-to, javascript, json
status=published
~~~~~~

<a href="http://grails.org" target="_blank"> 
![Grails logo](img/grails.png)
</a>


<div class="alert alert-warning">
This issue was encountered while using Grails version 2.3.11
</div>

In theory it should be as simple as:

1. Return JSON in your model from your controller
```groovy
def index() = {
	[data: data as JSON]
}
```
2. Render the model attribute without encoding using the raw() method
```groovy
<r:script>
	var data = ${raw(data)};
</r:script>
```

Unfortunately this does not work, at least when you are using the resources plugin. You know it does not work because all the quotes have been escaped and they should have not:
```html
<script>
	var data = {&quot;whatever&quot;:&quot;whatever&quot;};
<script>
```

It took me a while to find a way of doing it using the **applyCodec** taglib. Just replace the previous second step with this:
```groovy
<r:script>
	<g:applyCodec encodeAs="none">
		var data = ${data};
    </g:applyCodec>
</r:script>
```

as a result you will see that is has been rendered properly:

```html
<script>
	var data = {"whatever":"whatever"};
<script>
```

Link to related issues:

* https://jira.grails.org/browse/GRAILS-11829

## Update
You can also use gsp page directives like these ones to set the encoding mechanism on a single page basis:
- Remove enconding from EL expressions:
```
<%@ expressionCodec="none" %>
```
- Remove encoding from scriplets:
```
<%@ scriptletCodec="none" %>
```
- Remove encoding everywhere in the page:
```
<%@ defaultCodec="none" %>
```
