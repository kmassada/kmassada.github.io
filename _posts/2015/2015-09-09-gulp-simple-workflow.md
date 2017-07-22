---
layout:
title: "gulp simple workflow"
categories: [Laravel, JS]
date: 2015-09-07 12:00 -0400
tags: php,laravel,js,node
status: publish
published: true
---

Gulp is just a way to automate workflow. I like to use it to compile and minify resources. Not every framework can be like Rails and have this functionality built in.

installing gulp is easy, you will need [NodeJS](https://nodejs.org/en/), NodeJS has a complete installer for all the major OS out there. It comes with [NPM](https://www.npmjs.com) already installed.

Run the following command to update your npm version

~~~ bash
sudo npm install npm -g
~~~

Now you are ready to install gulp.

~~~ bash
sudo npm install --global gulp
~~~

here are some of the [official gulp docs](https://github.com/gulpjs/gulp/tree/master/docs) for more details on how to get started.

once you are inside your project directory, you can install gulp local to your project as well. it will download gulp to `nodes_modules` folder, and the --save-dev will keep track of your packages  in dev. ideally for production should have pre-compiled resources, making gulp a dev tool.

~~~ bash
npm init
npm install --save-dev gulp
~~~

In MAC I ran into some errors, after installing packages as global, it affected the local permissions, the quick fix, is this command

~~~ bash
sudo chown -R $(whoami) ~/.npm
~~~

We are going to save locally into Projectdir/nodes_modules all the modules required for our automation tasks. we will be compiling sass via the module `gulp-ruby-sass` (this needs ruby and sass to work). we are doing other tasks such as `concat, minify, uglify, rename` and are installing their respective required modules. Also working with [BOWER](http://bower.io/), see "laravel 5 additional resources". we briefly talk about bower and how it helps us in our workflow.

I tend to run these individually, to track errors.

~~~ bash
npm install gulp --save-dev
npm install gulp-minify-css --save-dev
npm install gulp-concat --save-dev
npm install gulp-uglify --save-dev
npm install gulp-rename --save-dev
npm install gulp-phpunit --save-dev
npm install gulp-ruby-sass --save-dev
npm install gulp-notify --save-dev
npm install gulp-bower --save-dev
~~~

The file reads well and verbosely, I tried to add comments explaining each function.

I start by declaring variables, and paths to my folders

~~~ javascript
var gulp = require('gulp'),
    sass = require('gulp-ruby-sass'),           // compiles sass to CSS
    minify = require('gulp-minify-css'),        // minifies CSS
    ...
    var paths = {
        'resources': {
            'sass'  : './public/sass/',
            'scss'  : './public/scss/',
    ...
~~~

`Bower` task just runs bower update, and `icons` task copies fonts and icons from a folder to another.
`/**/*.*` copies all the items in the folder and subfolders.

~~~ javascript
paths.assets.bower+'font-awesome/fonts/**/*.*',
~~~

phpunit is a very laravel centric task, it runs the `phpunit` test command on some items in a given location.

the sass, js and css are similar tasks

~~~ javascript
.pipe(sourcemaps.init()) //sourcemaps
.pipe(gulp.dest(paths.resources.js)) //destination
.pipe(sourcemaps.write())
.pipe(concat('app.js')) // concat
.pipe(rename({suffix: '.min'})) // minify
.pipe(uglify()) // uglify
~~~

I also use [live reload ](http://livereload.com)plugin. it monitors changes in the file system. As soon as you save a file browser reload. I'm currently working on refining this process, for now, including `.pipe(livereload())` and adding the browser plugin will refresh your pages.  


Live reload is tagged on, one of the most useful gulp tasks, watch. running the command `gulp watch` inside your project directory, listens to changes in the specified tasks, and will run a task update

~~~ javascript
gulp.task('watch', function() {
  livereload.listen();

  // watch scss files
  gulp.watch(paths.resources.css, function() {
    gulp.run('bootstrap-sass');
  });

  // watch js files
  gulp.watch(paths.resources.js, function() {
    gulp.run('js');
  });
});
~~~

and of course, it is worth mentioning the default task, while running `gulp` you can trigger synchronously tasks to be ran, one after the other. I've seen some workflows that tag on `watch` to the default, I use, the simple command `gulp` to prepare for deployment.

~~~ javascript
gulp.task('default',['bower', 'icons', 'js', 'css' , 'bootstrap-sass']);
~~~

Things to improve on:
- plugin free refresh in browser
- custom sass and bootstrap compiled to same css
- better notification on task completion, by using growl

{% gist kmassada/1457aab5aa8060a80059 %}
