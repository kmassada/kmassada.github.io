---
layout: single
title: "Laravel 5 Homestead Workflow"
categories: [Laravel]
date: 2015-09-07 12:00 -0400
tags: php laravel
status: publish
published: true
---

This post will be a little obscure to you, if you have no previous knowledge of Vagrant or Homestead, I recommend [laravel's homestead guide](http://laravel.com/docs/master/homestead) and also the [official vagrant guide](https://docs.vagrantup.com/v2/)

### Download laravel's vagrant box
first we download vagrant box for laravel,

~~~ bash
vagrant box add laravel/homestead
~~~

this will download the box named `"laravel/homestead"` from [HashiCorp's Atlas box catalog](https://atlas.hashicorp.com/boxes/search) and add it to your vagrant's box list.
You can verify the box exist by running:

~~~ bash
$ vagrant box list
laravel/homestead               (virtualbox, 0.2.7)
puppetlabs/centos-7.0-64-puppet (virtualbox, 1.0.1)
~~~

or verify your vagrant.d path

~~~ bash
$ ls ~/.vagrant.d/boxes/laravel*
laravel-VAGRANTSLASH-homestead/   
~~~

if you encounter any problems, download the box directly from [HashiCorp's Atlas box catalog](https://atlas.hashicorp.com/boxes/search) and add it like this:

~~~ bash
vagrant box add laravel/homestead path/to/your/box/file.box
~~~

### Homestead's workflow
Homestead's official workflow is that you clone homestead to your local environment, and bootstrap it to your local environment,  

~~~ bash
cd Projectfolder
git clone https://github.com/laravel/homestead.git Homestead
bash init.sh
~~~
this will essentially create the `Homestead.yaml` and place it in your `~/.homestead` directory, subsequently this will allow you to map each project folder to the same homestead box

~~~ yaml
folders:
    - map: ~/Code
      to: /home/vagrant/Code
~~~

### My Homestead structure
I favor keeping a single homestead box per project.

- This to me follows the vagrant practice of saving your vagrant file to your project, but excluding your .vagrant from your git repository.
- This also allows me to keep a `Homestead.yaml` inside my project folder, but separate from the actual Homestead project folder, following, their own convention of `bash init.sh` that copies the `Homestead.yaml` from the source the root of the `Homestead folder`.

Directory structure:

~~~
├── projectfolder/
│   ├── Homestead.yaml       # homestead config saved in project root
│   ├── public/
│   ├── Homestead/           # homestead project, also ignored in git
│   │   ├── Homestead.yaml
│   │   ├── LICENSE.txt
│   │   ├── Vagrantfile
│   │   ├── composer.json
│   │   ├── composer.lock
│   │   ├── homestead
│   │   ├── init.sh
│   │   ├── readme.md
│   │   ├── scripts/
│   │   ├── src/
│   │   │   └── stubs/     # homestead source configs, good reference for version changes
│   │   │       ├── Homestead.yaml
│   │   │       ├── LocalizedVagrantfile
│   │   │       ├── after.sh
│   │   │       └── aliases
│   │   └── vendor         # vendor required to bootstrap application
~~~
create homestead folder in the root of your project.

~~~ bash
cd Projectfolder
git clone https://github.com/laravel/homestead.git Homestead
mkdir -p Homestead/.homestead
~~~

exclude Homestead from .gitignore *this now comes default with L5.1*

~~~ bash
echo 'Homestead' >> .gitignore
~~~

import or create your current Homestead.yaml to the newly cloned Homestead

~~~ bash
cp Homestead.yaml Homestead/
OR
cp Homestead/src/stubs/Homestead.yaml Homestead
~~~

inside `Homestead/Vagrantfile` set the Homestead path

~~~ ruby
confDir = $confDir ||= File.expand_path("../Homestead")
~~~

and if you intend on keeping several homestead instances like me, do the following and define Homestead's default name

~~~ ruby
...
config.vm.define "laravel5dev" do |laravel5dev|
    end

    if File.exists? afterScriptPath then
        config.vm.provision "shell", path: afterScriptPath
    end
~~~

create keys, that will allow you to ssh into vagrant box,

~~~ bash
cd Projectfolder
ssh-keygen -t rsa -f "Homestead/.homestead/homestead@laravel5.dev" -C "homestead@laravel5.dev"
~~~

that's it, at this point you are ready for configuring our vm.

{% gist kmassada/052380e8490b8196ef87 %}

after configuration, we install the composer dependencies on Homestead and call `./homestead` from Homestead directory

~~~ bash
cd Homestead/
composer install
./homestead up
~~~

now your project is ready and served at: `http://localhost:8000`, or `http://localhost:2200` if port 8000 is busy, or if you are fancy, you can edit you /etc/hosts, and include a line for `laravel5.dev`

~~~ bash
$ sudo vi /etc/hosts
192.168.33.11 laravel5.dev www.laravel5.dev
~~~
