#ABOUT

This is just another attempt to keep myself uptodate with tech discoveries, explorations, all things I learn, all things I want to learn and some more.

#Dockerize
```
docker build -t kmassada.github.io .
docker run --rm -it -p 4000:4000 -v "$PWD":/usr/src/app -w /usr/src/app kmassada.github.io bash
export JEKYLL_ENV=development
bundle exec jekyll serve -H 0.0.0.0 --incremental --watch
```
