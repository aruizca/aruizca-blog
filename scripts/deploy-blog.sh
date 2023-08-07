#!/usr/bin/env bash

# Based on blog post: https://sangsoonam.github.io/2019/02/08/using-git-worktree-to-deploy-github-pages.html

cd "$(dirname "$0")"/..

directory=output
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
  git pull &&
  git config pull.rebase true &&
  git add --all &&
  git commit -m "Deploy updates $(date +'%Y-%m-%d %H:%M:%S')" &&
  git push origin $branch

echo -e "\033[0;32mCleaning up...\033[0m"
cd .. &&
git worktree remove $directory