# gh-pages branch

To publish to GitHub Pages, switch to the `main` branch and run `make publish-docs`.

You can also use the following commands but be warned this is not as reproducible as `make publish-docs`:

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
