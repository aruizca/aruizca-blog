title=Migrating from Grails 2.2 to 2.3
date=2014-03-14
author=Angel Ruiz
type=post
tags=grails, migration, groovy
status=published
~~~~~~

<a href="http://grails.org" target="_blank">
![Grails logo](img/grails.png)
</a>

I am writing this post to record all the things I have done in order to migrate an existing Grails 2.2.x app to 2.3.x.

The reasons for me to upgrade are:

* Project progress is at an early stage where is not very risky to do that. We also have a considerable amount of automatic tests. You have also need to take into consideration that the more major versions you skip, the harder it gets to migrate to the latest version.
* Switched dependency resolution engine from Ivy to Aether. I have had problems with Ivy resolving transitive dependencies and snapshots of my own plugin dependencies.
* **"Forked Execution"** and the **"Test Runner Daemon"** should speed up the tests execution and therefore speed up 
  the tests development. This is one of the mayor caveats I have found in Grails so far. We'll see if they have fixed it with this two new features.
  
<div class="index-break"></div>  

First of all I have read the following posts about this subject, which I think are essential to perform the task at hand:

* [Upgrading from Grails 2.2 - Reference Documentation](http://grails.org/doc/2.3.x/guide/upgradingFromPreviousVersionsOfGrails.html)
* [Migrating to Grails 2.3](http://www.objectpartners.com/2013/10/08/migrating-to-grails-2-3/)
* [Upgrading to Grails 2.3 – Gotchas](http://blog.milesburton.com/2013/12/11/upgrading-to-grails-2-3-gotchas/)

I decided to follow a different approach by specifying what files need to be changed, why and how:

## Files I had to alter:

---

### application.properties
You need to upgrade the grails version number:

```
app.grails.version=2.3.7
```

### BuildConfig.groovy
* The groupId should be now in the Config.groovy file. Se next file changes

* Enable forked execution (host app and plugins):
```groovy
grails.project.fork = [
    // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
    //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

    // configure settings for the test-app JVM, uses the daemon by default
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    // configure settings for the run-app JVM
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the run-war JVM
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the Console UI JVM
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]
```

<div class="alert alert-warning">
<i class="fa fa-exclamation-triangle fa-fw"></i> <strong>Important note!!</strong><br/>
At the end I had to disable the forked execution becaue it does not get along very well with IntelliJ IDEA debugging :-(
</div>

* Explicitely set Maven Aether as the default dependency resolution engine (host app and plugins):
```
grails.project.dependency.resolver = "maven" // or ivy
```

* Upgrade the following plugin dependencies if you are planning to upgrade a Grails host app:
```
// plugins for the build system only
build ":tomcat:7.0.52.1"

// plugins for the compile step
compile ":scaffolding:2.0.3"

// plugins needed at runtime but not for compilation
runtime ":hibernate4:4.3.4.1" // or ":hibernate:3.6.10.9"
runtime ":database-migration:1.3.8"
runtime ":resources:1.2.7"
// Uncomment these (or add new ones) to enable additional resources capabilities
//runtime ":zipped-resources:1.0.1"
//runtime ":cached-resources:1.1"
//runtime ":yui-minify-resources:0.1.5"
```

* If as the snipped above, you want to use Hibernate 4 instead of Hibernate 3, you will have to make sure that your plugin dependencies exclude the Hibernate 3 dependency. This is due to the fact that they are using different artifactId ("**hibernate4**" instead of "**hibernate**"). You can exclude dependencies in plugins like this:

```
compile(':plugin-artifactId:version') {
    excludes "hibernate"
}
```

* Remove Spock dependencies as they already come built-in with Grails 2.3 (host app and plugins).

* Upgrade the following plugin dependencies if you are planning to upgrade a Grails plugin:

```
build(":release:3.0.1",
    ":rest-client-builder:1.0.3") {
    export = false
}
```

Note that you might need to upgrade some other plugins.

### Config.groovy
* Automatic reloading is not enabled by default, so if you want it back add the following line:

```
grails.reload.enabled = true
```
* And then the change mentioned in teh previous section that says that the groupId should be specified here now:

```
grails.project.groupId = "whatever" // change this to alter the default package name and Maven publishing destination
```

* There are quite a few other little changes. So I suggest creating a new empty Grails app from scratch using Grails 2.3.x and compare the resulting Config.groovy file with your own.

### All Integration Tests that extend GroovyTestCase
All these tests need to remove that inheritance and annotate the class with this Mixin:

```
@TestMixin(IntegrationTestMixin)
```

### ~/.grails/settings.groovy
If like me, you have your repositories and credentials declared globally, then your settings.xml file should go from this:

```
...
grails.project.ivy.authentication = {
    repositories {
        mavenRepo "whatever url"

    credentials {
        realm = "Sonatype Nexus Repository Manager"
        host = "whatever"
        username = "whatever"
        password = "whatever"
    }
}
...
```

to this:

```
...
grails.project.ivy.authentication = {
    repositories {
    	mavenLocal()
        mavenRepo("whatever url") {
          if (owner.grailsVersion ==~ /2\.3\..*/) {
              updatePolicy "always"
              auth([
                  username: 'whatever',
                  password: 'whatever'
              ])
          }
    	}
    }

    credentials {
        realm = "Sonatype Nexus Repository Manager"
        host = "whatever"
        username = "whatever"
        password = "whatever"
    }
}
...
```

The possible values for **_"updatePolicy"_** are:

* **never** – Never check for new snapshots.
* **always** – Always check for new snapshots.
* **daily** – Check once a day for new snapshots (the default).
* **interval:x** – Check once every x minutes for new snapshots.

I will keep updating this post if I encounter another migration issue.

I hope you find it useful. Cheers.

---

- **Update 1**: Class reloading has to be enabled inside the Config.groovy file not the BuildConfig.groovy file.

- **Update 2**: Disabled forked execution because it breaks debugging in IntelliJ IDEA

- **Update 3**: Added possible values for the updatePolicy maven repository settings parameter