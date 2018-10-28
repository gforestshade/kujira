rm -r docs/*
bin/hugo
cd docs
git add .
git commit -m "Update documentation"
cd ..
git push origin gh-pages
