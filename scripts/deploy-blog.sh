#!/usr/bin/env bash

cd "$(dirname "$0")"/..

directory=blog
branch=gh-pages
build_command() {
  mvn jbake:generate
}

echo -e "\033[0;32mDeleting old content...\033[0m"
rm -rf $directory

echo -e "\033[0;32mChecking out $branch....\033[0m"
git worktree add $directory $branch

echo -e "\033[0;32mGenerating site...\033[0m"
build_command

echo -e "\033[0;32mDeploying $branch branch...\033[0m"
cd $directory &&
  git add --all &&

  git commit -m "Deploy updates $(date +'%Y-%m-%d %H:%M:%S')" &&
  git push origin $branch

echo -e "\033[0;32mCleaning up...\033[0m"
git worktree remove $directory

echo -e "\033[0;32mGenerating site to resume work...\033[0m"
build_command