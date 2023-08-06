aruizca's blog
==============

To generate a preview of the site, you will need to change the `site.host` property at `jbake.properties` file as follows:

```
site.host=http://localhost:63342/aruizca-blog
```

and then execute:

```bash
mvn jbake:generate
```

To publish the content publicly on GitHub pages:

```bash
./scripts/deploy/blog.sh
```

⚠️WARNING! Remember to rollback the changes on the `jbake.properties` file.