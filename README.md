aruizca's blog
==============

## Draft Workflow

To generate a preview of the site, you will need to change the `site.host` property at `jbake.properties` file by
commenting and uncommenting so it appears as follows:

```
site.host=http://127.0.0.1:8820/
#site.host=https://aruizca.github.io/aruizca-blog
```

and then execute:

```bash
mvn jbake:inline
```

## Publish Workflow

⚠️WARNING! Remember to rollback the changes on the `jbake.properties` file.

It should appear as follows:

```
#site.host=http://127.0.0.1:8820/
site.host=https://aruizca.github.io/aruizca-blog
```

Then, too publish the content publicly on GitHub pages execute the following script:

```bash
./scripts/deploy/blog.sh
```

