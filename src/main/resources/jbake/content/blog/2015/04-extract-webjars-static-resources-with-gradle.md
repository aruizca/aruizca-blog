title=Extract Webjars static resources with Gradle for jBake (or anything really...)
date=2015-08-31
author=Angel Ruiz
type=post
tags=gradle, java, webjars, static resources
status=published
~~~~~~

<a href="https://www.webjars.org/" target="_blank"> 
![gradle and webjars](img/gradle-webjars.png)
</a>

For those of you who never heard of it before, [WebJars](http://www.webjars.org/) is an open and community driven initiative that tries to leverage the existing Maven based dependecy resolution tools and principles to manage the client side dependencies of your web application. Each WebJar is a standar JAR file that contains a set of curated files (Classic WebJars) for a given library. Recently you can also reference Bower and NPM packages but I would not recommend it.

Previously I have tried using Bower alongside both Grunt and Gulp and they brought me straight back to the times were Ant was the predominant build tool in the Java EE world where everyone was doing its own thing with a complete lack of conventions.

After using WebJars in Java web projects I started looking how to use it in static web sites, more especifically those generated with [jBake](http://jbake.org/).

The final aim is to avoid checking in the web dependencies, like Javaacript based libraries, in our SCM tool. It turns out that [jBake can be used with Gradle](http://melix.github.io/blog/2014/02/hosting-jbake-github.html), which means that we have the chance of managing all my dependencies using a single tool that happens to be a lot better than anything available on the Javascript-Node ecosystem.

Declaring your WebJars dependency is as easy as declaring any other Maven based dependency, but in this case we group them in a [custom Gradle dependency configuration](https://docs.gradle.org/current/userguide/artifact_dependencies_tutorial.html#configurations) that we will call `webjars`:
```
...
dependencies {
    webjars 'org.webjars:jquery:2.1.3'
    webjars 'org.webjars:bootstrap:3.3.4'
    webjars 'org.webjars:highlightjs:8.4-4'
    webjars 'org.webjars:font-awesome:4.3.0-1'
    webjars 'org.webjars:jquery.tocify.js:1.9.0'
    webjars 'org.webjars:Magnific-Popup:1.0.0'
}
...
```

In the case of jBake we need a custom task to extract the web dependencies assets at build time from the resolved WebJars:
```
task('webjars resources extraction', type: Copy) {
    configurations.webjars.each {jar ->

        def config = configurations.webjars.resolvedConfiguration
        def artifact = config.resolvedArtifacts.find {
            it.file.toString() == jar.absolutePath
        }

        def upStreamVersion = "${artifact.moduleVersion.id.version}"
        upStreamVersion = upStreamVersion.replaceAll(/(-[\d.-]+)/, '')

        copy {
            from zipTree(jar)
            into file("${buildDir}/webjars-content/${artifact.name}")
        }
        copy {
            from "${buildDir}/webjars-content/${artifact.name}/META-INF/resources/webjars/${artifact.name}/${upStreamVersion}",
                 "${buildDir}/webjars-content/${artifact.name}/META-INF/resources/webjars/${artifact.name}/${artifact.moduleVersion.id.version}"

            into "${jbake.input}/assets/vendor/${artifact.name}"
        }
    }
}
```
This task will extract all the libraries inside a folder called `/assets/vendor/`. As you can appreciate this script can be easily customized to fit other platforms and build processes.

You can check my entire [`build.gradle` file at GitHub for reference](https://github.com/aruizca/ajaxanywhere-site/blob/master/build.gradle).

There are two things that I would like to stand out and I hope, albeit improbable, the message will get out there:

1. By 2016, no project should store their web dependencies in their SCM tool. The same way we don do it with our server side dependencies or IDE metadata.
2. The fact that I am using jBake here is just an anecdote. This proof of concept sets the basis on which to develop applications for all sort of platforms, including NodeJS, using Gradle as the build tool to perform all kind of operations including the web dependencies resolution using with the WebJars. I am pretty sure that **Gradle + WebJars combined with the [Asset-Pipeline](https://github.com/bertramdev/asset-pipeline-core/) are the best toolset to develop multiplatform web applications**.








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