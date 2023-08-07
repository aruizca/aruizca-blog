title=Integrated vs Functional testing: how to test REST APIs in Grails using Spock
date=2015-03-19
author=Angel Ruiz
type=post
tags=grails, spock, testing
status=published
~~~~~~

<a href="https://spockframework.org/" target="_blank"> 
![Grails and Spock](img/grails-spock.png)
</a>

<div class="alert alert-warning">
<i class="fa fa-exclamation-triangle fa-fw"></i> This guide was written using <strong>Grails 2.4.4</strong> although it should work the same for Grails 2.3.x and 3.x (almost the same :-P)<br/>
</div>

Since current [official documentation](http://grails.github.io/grails-doc/2.4.x/guide/testing.html) only covers unit testing for controllers  and that it took me a while to to figure them out completely, I thought I would leave it here in case it helps someone else.

The reason for writing these tests was to validate some REST API endpoints implemented using Grails Controllers.

<div class="index-break"></div>

So given the following simple and pure didactic domain object:
```groovy
class Book {

    String title

    static constraints = {
        title blank: false, unique: true
    }
}
```
and its respective controller:
```groovy
import grails.converters.JSON
import grails.rest.RestfulController

class BookController extends RestfulController<Book> {
    static responseFormats = ['json']

    BookController() {
        super(Book)
    }

    @Override
    def save() {
        def jsonParams = request.JSON
        render new Book(title: jsonParams.title).save() as JSON
    }
}
```

with its respective URL mapping:
```
...
"/books/$id?"(controller: 'book') {
	action = [POST: 'save']
}
...
```
        
These are the two type of tests you can implement:

## Integration Test

First of all, forget about the `@TestFor` annotations, because those are just for unit tests.

This is how the integration test looks like:
```groovy
import grails.test.spock.IntegrationSpec
import rest.sample.Book
import rest.sample.BookController
import spock.lang.Shared

class BookControllerSpec extends IntegrationSpec {

    @Shared BookController controller = new BookController()

    def setup() {
        // Initialize DB
        new Book(title: "title1").save()
    }

    def cleanup() {
    }

    void "test creating a book"() {
        when:
        // Set request JSON body
        controller.request.json = [
            title: "title2"
        ]
        controller.save()
        def response = controller.response.json

        then:
        response.title == "title2"
        Book.count == 2
    }
}
```

As you can appreciate **this is not really the best way to test a REST API** in my opinion. Not only look a bit cumbersome but also and more importantly, it is not a really end to end (e2e) test.

So how do we implemet a complete e2e test using a REST client if the Integration tests does not run a web server and Grails lacks built-in support for Functional testing (Grails 3.x [has it](http://grails.github.io/grails-doc/3.0.x/guide/testing.html#functionalTesting))? Let's find the answer in the next section.

## Functional Test
First of all we need to enable functional test via plugin. There are quite a few to choose from but we need those that support Spock tests like:

* [Funcky Spock Plugin](https://grails.org/plugin/funky-spock): which is good enough to test a REST API.
* [Geb integration for Grails Plugin](https://grails.org/plugin/geb): on top of enabling functional Spock tests, it also allows you to use the [**Geb** e2e browser testing framework](http://www.gebish.org/)

Although the first one is more than enough, I chose the Geb plugin to be inline with Grails 3 choice :-) **To integrate the Geb plugin**, we need to add the following dependencies in our `BuildConfig.groovy`:

```
dependencies {
  ...
  test "org.gebish:geb-spock:0.10.0"
  ...
}

plugins {
  ...
  test ":geb:0.10.0"
  ...
}
```

Then I had to create the folder: `/tests/functional` to put our functional tests there.

As the REST client I will be using the [**Rest Client Builder plugin**](http://grails.org/plugin/rest-client-builder).

This is how the functional test looks like with the forementioned "ingredients":

```groovy
import grails.plugins.rest.client.RestBuilder
import grails.plugins.rest.client.RestResponse
import grails.test.spock.IntegrationSpec
import rest.sample.Book
import spock.lang.Shared

class BookControllerFunctionalSpec extends IntegrationSpec {
    
    @Shared
    def grailsApplication

    def setup() {
        // Initialize DB
        new Book(title: "title1").save()
    }

    def cleanup() {
    }

    void "test creating a book"() {
        given:
        RestBuilder rest = new RestBuilder()

        when:
        RestResponse response = rest.post("http://localhost:8080/${grailsApplication.metadata.'app.name'}/books") {
            json([
                title: "title2"
            ])
        }

        then:
        response.status == 200
        response.json.title == "title2"
        Book.count == 2
    }
}
```

Thank you for reaching this paragraph. I hope it helped you. If any of you guys think there is a better approach, by all means, please let me know.

You can find the rpoject with the source code here: https://github.com/aruizca/rest-api-test-example
