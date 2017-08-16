#ABOUT

This is just another attempt to keep myself uptodate with tech discoveries, explorations, all things I learn, all things I want to learn and some more.

# Testing theme 
```
#Linux jekyll-test 4.10.0-32-generic #36~16.04.1-Ubuntu SMP Wed Aug 9 09:19:02 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
git clone https://github.com/mmistakes/minimal-mistakes.git
cd minimal-mistakes
sudo apt-get install rubygems ruby-dev
sudo apt-get install linux-headers-$(uname -r) build-essential  zlib1g-dev
sudo gem install jekyll bundler
sudo gem install sass --no-user-install
bundle install
bundle exec jekyll serve -H 0.0.0.0 --incremental --watch
```

#Dockerize
```
docker build -t kmassada.github.io .
docker run --rm -it -p 4000:4000 -v "$PWD":/usr/src/app -w /usr/src/app kmassada.github.io bash
export JEKYLL_ENV=development
bundle exec jekyll serve -H 0.0.0.0 --incremental --watch
```

# mods
```
_css
reset
variables

_data
nav
ui-text

_layouts
footer
```