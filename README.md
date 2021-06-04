# gh-pages branch

```bash
git switch main
dune clean
make doc

git switch gh-pages
rsync -avp --delete --copy-links _build/html/ docs && rsync -avp --delete --copy-links _build/default/_doc/_html/ docs/ocaml/ ; touch docs/.nojekyll
git add -A
git commit -m "Updated site"
git push
```
