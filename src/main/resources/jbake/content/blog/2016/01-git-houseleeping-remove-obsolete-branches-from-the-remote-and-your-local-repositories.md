title=Git housekeeping: remove "obsolete" branches from the remote and your local repositories
date=2016-07-31
author=Angel Ruiz
type=post
tags=clean, clean-up, remove, repositories, prune, local, remote, branches
status=published
~~~~~~

![git clean](img/git-clean.png)

Recently I was faced with the task of cleaning up a Git repository whose branches were not "pruned" for a few years, so I am talking about several hundreds of branches.

This situation can make using Git through the command line or a GUI front-end client a very cumbersome experiece. That's why I usually recommend, as a general rule, to delete any feature or bugfix branch after it gets merged to a "higher level" branch. Because they became **"useless"** and only add noise.

<div class="index-break"></div>

The real task here is to clean up the remote branch as you can always clone the repo locally again and start from scratch. I started deleting them manually because I am not a Git guru and I am very cautius whenever I have to tempre with the remote repositorory. Soon enough I realized I was not getting anywhere and start looking for a script to help me.

# Script to clean up the remote repository
<div class="alert alert-danger" role="alert">
  <i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Please use it at your own risk. <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
  <br/>
  It worked for me using Git 2.9.2, but it should work with earlier versions.
  <br/>
  Although branches are removed, the metadata of the branch and the relevant commits will remain there, so it is always possible to recreate any branch that should not have been deleted.
</div>

```
## Remove remote branches that are already merged with master
git checkout master
# Dry-run: check the branch names list before they get deleted for good
git branch -ar --merged master | grep -v HEAD | grep -v master
# If you are really sure, then remove them from remote repo
git branch -ar --merged master | grep -v HEAD | grep -v master | sed "s/origin\///" | xargs -n 1 git push origin --delete
```

## Breaking it down

```
git checkout master
```
- In this case I chose the master branch, but if you want to clean more recent branches you can replace all the `master` branch references with `develop` in all the commands.

```
git branch -ar --merged master
```
- Get list of remote branches that have already been merged with the `master` branch

```
grep -v HEAD | grep -v master
```
- Remove those items from the list that contains the words `HEAD` or `master`

```
sed "s/origin\///"
```
- For each remaining element in the list, remove the `origin/` name prefix

```
xargs -n 1 git push origin --delete
```
- Execute the git remote branch delete command for each element in the list.

# Script to clean up the local repository

<div class="alert alert-danger" role="alert">
    <h3>Deprecated</h3>
    <p>Just use <a href="https://github.com/tj/git-extras" target="_blank">Git Extras</a> instead (eg: `git delete-merged-branches` or `git delete-squashed-branches`</p>
</div>

If you have been working on a repository for a while, it might be that you have local copy of a few branches that are no longer valid and need to be "pruned".

To achieve that we can execute a small variation of the previous script.

```
## Remove local branches that are already merged with master

git checkout master
# Dry-run: check the branch names list before they are deleted
git branch --merged master | grep -v "master"
# If you are really sure, then remove them from local repo
git branch --merged master | grep -v "master" | xargs -n 1 git branch -d
```

###Acknowlegment
Thanks to [@StevenHarman](https://twitter.com/stevenharman), whose [post](http://stevenharman.net/git-clean-delete-already-merged-branches) showed me how to clean the local repo and gave me the idea to do same on the remote repo.

Feedback and improvements are welcome!! :-)