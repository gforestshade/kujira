#!/bin/sh

#if [ "`git status -s`" ]
#then
#    echo "The working directory is dirty. Please commit any pending changes."
#    exit 1;
#fi

echo "Deleting old publication"
git worktree remove --force docs
mkdir docs


echo "Checking out gh-pages branch docs"
git worktree add -B gh-pages docs remotes/origin/gh-pages

echo "Removing existing files"
rm -rf docs/*

echo "Generating site"
bin/hugo

#echo "Updating gh-pages branch"
cd docs && git add --all && git commit -m "Update Documentation"

#echo "Pushing to github"
git push origin gh-pages
