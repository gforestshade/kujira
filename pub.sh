rm -r docs
bin/hugo && cd docs && git add --all && git commit -m "Update documentation" && cd ..
git push upstream gh-pages
