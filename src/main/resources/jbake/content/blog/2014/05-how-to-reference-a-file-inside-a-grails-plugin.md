title=How to reference a file inside a Grails plugin
date=2014-04-07
author=Angel Ruiz
type=post
tags=grails, plugins, how-to
status=published
~~~~~~

<a href="http://grails.org" target="_blank"> 
![Grails logo](img/grails.png)
</a>

Recently I had to creat a Groovy script that copies some files from my plugin to the host application. The problem is I did not know how to reference those files inside my plugin.
```
String yourPluginDir = GrailsPluginUtils.pluginInfos.find { it.name == 'your-plugin-name' }.pluginDir
```