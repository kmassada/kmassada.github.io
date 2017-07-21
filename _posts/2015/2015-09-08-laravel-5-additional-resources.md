---
layout: post
title: "Laravel 5 additional resources"
categories: [Laravel]
date: "2015-09-07"
tags: php,laravel
status: publish
published: true
---

Laravel on it's own is a powerful and autonomous framework. With the additions of [Laravel Elixir](http://laravel.com/docs/master/elixir) to manage compilation of CSS and JS in your project and [Laravel Homestead](http://laravel.com/docs/master/homestead) that serves as a stand alone sandbox for your own local environment, the framework makes a compelling case for a "turnkey" framework.

Here are some plugins that are part of every laravel project I've been working on, and in my mind are 'core'.

### Bower

[Bower](http://bower.io/) is basically a simple package manager. For resources like JQuery, Bootstrap, Data-Tables, etc. I like to keep them separate from composer and it's vendor folder. Bower offers dependency and package management via `bower.json`

Follow the instruction at [bower's documentation](http://bower.io/) to install bower

we then create the `.bowerrc` file, it directs bower where to save the resources

~~~ bash
cd Projectfolder
touch .bowerrc
~~~
~~~ json
{
  "directory": "resources/assets/bower"
}
~~~

we then initialize bower. answer all the questions, you can leave them all default

~~~ bash
bower init
~~~

we then install some resources we want to use in our laravel app.

~~~ bash
bower install jquery
bower install bootstrap
~~~

as part of my workflow using elixir, I copy the latest JQuery file to `./resources/assets/js/`, elixir looks in that folder for js files, and compiles them

~~~ javascript
//simple path variable
var paths = {
  'resources': {
    'bower': './resources/assets/bower/',
    'js': './resources/assets/js/',
  },
};

elixir(function(mix) {
    mix.copy(paths.resources.bower.'jquery/dist/jquery.min.js', path.resources.js);

    // elixir looks for js files in ./resources/assets/js/
    mix.scripts([
    'jquery.js',
    'other.js',
    ]);
});
~~~

at this point you could directly reference JQuery, or all the javascript files you've compiled by including it in a header statement like:

~~~ html
<script src="{% raw %}{{ elixir('js/app.js') }}{% endraw %}"></script>
~~~

## WayGenerator / Laravel-5-Generators-Extended

In laravel 4 this package allows to generate models and controllers, all this was fixed natively in laravel5, but this package still has a few helpful custom generators such as:

- make:migration:schema
- make:migration:pivot
- make:seed

the install guide is very comprehensive and [can be found here](https://github.com/laracasts/Laravel-5-Generators-Extended)
## Faker

[Faker](https://github.com/fzaninotto/Faker) is an extension of the ruby's Faker package, it generates pretty much any fake data you need in a sample application.
to install faker, run this at the root of your project

~~~ bash
composer require fzaninotto/faker
~~~

here's an example of how I user faker to seed data

~~~ php
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use App\Todo;
use App\Tag;

// Composer: "fzaninotto/faker": "v1.3.0"
use Faker\Factory as Faker;

class TodosTableSeeder extends Seeder {

	public function run()
	{
		$faker = Faker::create();

		foreach(range(1, 20) as $index)
		{
			Todo::create([
			'user_id' => rand(1,4),
			'priority_id' => rand(1,4),
			'title' => implode($faker->sentences(2)),
			'notes' => implode($faker->paragraphs(4)),
			'completed'=> true,
			'active' => true,
			]);
		}
  }
}
~~~
