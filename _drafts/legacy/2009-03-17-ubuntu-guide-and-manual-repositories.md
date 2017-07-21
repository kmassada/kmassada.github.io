---
layout: post
title: 'Ubuntu: Guide and Manual Repositories'
date: 2009-03-17 15:35:00.000000000 -04:00
categories:
- Repositories
- Tools and Utilities
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '3542008333848512168'
author:
  login: kmassada
  email: kmassada@gmail.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<p><span style="text-decoration:underline;"><strong>THE GUIDE: </strong></span></p>
<p>Ubuntu have a guide for each of its releases. Here is the link to the <a title="Ubuntu Guides Page" href="http://ubuntuguide.org/wiki/Main_Page">Ubuntu Guides page</a>, where you can select a guide for your version of ubuntu. The reason why this was important for me is because as a beginner that's where you get a general understanding of the OS, and the first steps you need to take.<br />
<h3><span style="text-decoration:underline;"><strong>REPOSITORIES:</strong></span></h3>
<p>
<h3>Add Repositories using Synaptic Package Manager</h3>
<p>This is the preferred method.
<ul> 
<li>System -&gt; Administration -&gt; Synaptic Manager -&gt; Settings -&gt; Repositories.</li>
<p> 
<li>Here you can enable the repositories for Ubuntu Software and Third Party Software.</li>
<p> 
<li>For Third Party Software select Add -&gt; enter the repository's address. It will have a format similar to:</li>
<p>
<blockquote><strong>deb http://packages.medibuntu.org/ intrepid free non-free<br />deb-src http://packages.medibuntu.org/ intrepid free non-free</strong></p></blockquote>
<p> 
<li>Download the repository key to a folder.</li>
<p> 
<li><em>Example:</em> The Medibuntu key can be downloaded from http://packages.medibuntu.org/medibuntu-key.gpgThen add the key from:</li>
<p> 
<li>System -&gt; Administration -&gt; Synaptic Manager -&gt; Settings -&gt; Repositories -&gt; Authentication -&gt; Import Key File...</li>
<p> 
<li>(Alternatively, you can manually add the key from the command line Terminal. See <a href="http://ubuntuguide.org/wiki/Ubuntu:Intrepid#Add_Repository_keys">Add Repository keys</a>.)</li>
<p></ul>
<p>
<ul> 
<li>Refresh the package list from the new repository:</li>
<p> 
<li>Synaptic -&gt; Reload</li>
<p></ul>
<p>
<ul> 
<li>Here is how to manually edit repositories using the terminal:</li>
<p></ul>
<p>
<blockquote>
<p style="text-align:left;"><strong> sudo gedit /etc/apt/sources.list</strong></p>
<p></p></blockquote>
<p>after adding the repository you get an error that is asking you for the public key to that repository. In linux you will see lots of people sign programs,emails, etc with a public key. Some repositories have a public key which you need to download to access. There are a few pages on wikipedia about it<br />
<blockquote><a href="http://en.wikipedia.org/wiki/Public-key_cryptography">http://en.wikipedia.org/wiki/Public-key_cryptography</a></p></blockquote>
<p>All you need to know is the process to use when you see that. This is the template<br />
<blockquote><strong>gpg --keyserver subkeys.pgp.net --recv KEY<br />gpg --export --armor KEY | sudo apt-key add -</strong></p></blockquote>
<p>When you get an error message, replace the word "KEY" with the numbers in the eror message. For your error you would enter this command<br />
<blockquote><strong>gpg --keyserver subkeys.pgp.net --recv F120156012B83718</strong></p></blockquote>
<p>After you press enter and it sends the command, you would enter the second line<br />
<blockquote><strong>gpg --export --armor F120156012B83718 | sudo apt-key add -</strong></p></blockquote>
<p>After that, the key will be added to a list and the error will not appear.</p>
<p>What the is the use of repositories? Its adds a list of a specific set of softwares to your synaptic manager (the more advanced version of window's Add/Remove Software).</p>
<p>-------------------</p>
<p><span style="color:#808000;"><strong>Since the release of Karmic Koala, most ubuntu repositories moved to PPA, and you can now add any repository by using a simple command. For example, to add the repository for the chromium browser, just run:</strong></span><br />
<blockquote><span style="color:#000000;"><strong>sudo add-apt-repository ppa:chromium-daily</strong></span></p></blockquote>
<p><span style="color:#808000;"><strong>The PPA will be added, with its GPG key. If you are still not sure of how this works, go to add any PPA </strong></span><a title="PPA ADD Guide" href="https://launchpad.net/+help/soyuz/ppa-sources-list.html"><span style="color:#808000;"><strong>Follow Guide</strong></span></a><span style="color:#808000;"><strong>.</strong></span></p>
<p><span style="color:#808000;"><strong><span style="color:#ff6600;">Since PPA has become very popular, the concern also emerged of how do you remove them, when you want to. There are special softwares, like ubuntu tweak, that take care of it for you, but i've found a tool called ppa-purge that takes out the ppa, the softwares in a neat way. (06/22/2010)<span style="color:#808000;"> Quick update, Ubuntu tweak just announced they will be supporting ppa purge in their product. </span></span></strong></span></p>
<p><strong><span style="color:#ff6600;">ppa-purge is very easy to use. How this works is e.g If I wanted to remove say the </span></strong><a href="http://bigbrovar.aoizora.org/index.php/2009/02/14/blueman-an-awesome-bluetooth-manager-for-ubuntu/"><strong><span style="color:#ff6600;">blueman</span></strong></a><strong><span style="color:#ff6600;"> PPA I just go to terminal and paste the following</span></strong><br />
<blockquote><code><strong>sudo ppa-purge ppa:blueman/ppa/ </strong></code></p></blockquote>
<p><strong><span style="color:#ff6600;">A break down of how this work is</span></strong><br />
<blockquote><code><strong>sudo ppa-purge ppa:repository-name/subdirectory</strong></code></p></blockquote>
<p><strong><span style="color:#ff6600;">e.g ‘deb http://ppa.launchpad.net/blueman/ppa/ubuntu karmic main’ the part in bold is the part you need to add to</span></strong><br />
<blockquote><strong>sudo ppa-purge ppa:</strong></p></blockquote>
<p><span style="color:#ff6600;"><strong>to make it</strong></span><br />
<blockquote><code><strong>sudo</strong><strong> ppa-purge ppa:</strong><strong>blueman/ppa</strong></code><br /><strong> </strong></p></blockquote>
<p><span style="color:#ff6600;"><strong>The ppa-purge belongs to the GetDeb Repostories, heres how you could add and install it:<br /></strong></span><br />
<blockquote><code><code><strong> sudo bash -c "echo 'deb http://archive.getdeb.net/ubuntu lucid-getdeb apps'        &gt;&gt; /etc/apt/sources.list"</strong></code></code><br /><span style="color:#ff6600;"><strong>then</strong></span><br />
<blockquote><strong>wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -</strong></p></blockquote>
<p><strong><span style="color:#ff6600;">now install</span></strong><br />
<blockquote><code><code><strong>sudo apt-get update<br />sudo apt-get install ppa-purge</strong><br /></code></code></p></blockquote>
<p></p></blockquote>
