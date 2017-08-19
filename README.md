# ABOUT

This is just another attempt to keep myself uptodate with tech discoveries, explorations, all things I learn, all things I want to learn and some more.

# Testing theme 
```
#Linux jekyll-test 4.10.0-32-generic #36~16.04.1-Ubuntu SMP Wed Aug 9 09:19:02 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
git clone https://github.com/mmistakes/minimal-mistakes.git
cd minimal-mistakes
sudo apt-get install -qy rubygems ruby-dev linux-headers-$(uname -r) build-essential  zlib1g-dev locales
locale-gen en_US.UTF-8
localedef -i en_US -f UTF-8 en_US.UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8" 
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

#upgrading 
```
git checkout -b jekyll-X.X
git merge -s ours master
git checkout master
git merge jekyll-X.X
git push origin master
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