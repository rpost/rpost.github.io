#jekyll serve --livereload --drafts

docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  --publish [::1]:4000:4000 \
  --publish [::1]:35729:35729 \
  jekyll/jekyll:4.2.0 \
  jekyll serve --livereload --drafts