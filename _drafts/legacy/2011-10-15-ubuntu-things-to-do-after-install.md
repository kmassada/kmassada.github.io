---
layout:
title: "Ubuntu Things to do after install"
date: 2011-10-15 00:26 -0400
categories:
- Tools and Utilities
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '1712611619553430431'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<p>1- Install<a href="http://www.techronicles.net/2009/05/ubuntu-tweaks.html"> ubuntu-tweak</a></p>
<p>Since when I wrote about Ubuntu tweak a while back they have improved considerably, here is what I use it for</p>
<ul>
<li>Change all my default folders (pictures, documents, desktop) to my second hard drive mounted at /Main, so instead of /home/user/pictures, my default folder is at /Main/pictures, this is so I can use hard drive on other boots, and keep data independent from Ubuntu. </li>
<li>Install the ppa's for my favorite apps</li>
<li>Setup compiz corner actions</li>
<li>Clean apt-cache, and configs</li>
<li>PPA purge (remove/downgrade apps, then delete ppa)</li>
</ul>
<div>The good news is they are in a restructure phase of their GUI to fit in perfectly 11.10, they bad news is, its  not all quite ready. To install the newer version run the following command. </div>
<div></div>
<blockquote><blockquote><span style="color:red;font-family:inherit;">sudo add-apt-repository ppa:tualatrix/next</span></p></blockquote>
<blockquote><p><span style="color:red;font-family:inherit;">sudo apt-get update</span></p></blockquote>
<blockquote><p><span style="color:red;font-family:inherit;">sudo apt-get install ubuntu-tweak</span></p></blockquote>
</blockquote>
<p>To access old functions not yet included such as ppa additions, or compiz actions run this command</p>
<blockquote><p><span style="color:red;">sudo apt-get install ubuntu-tweak-0</span></p></blockquote>
<p>2- Config items gnome-tweak, compiz settings manager</p>
<p>
<blockquote><span style="color:red;">sudo apt-get install gnome-tweak-tool<br />sudo apt-get install compizconfig-settings-manager<br />sudo apt-get install dconf-tools</span></p></blockquote>
<div></div>
<div><b>gnome-tweak-tool</b> was meant to edit settings in gnome shell but works beautifully in unity, install <b>compizconfig-settings-manager</b> to get a reasonable GUI that will allow you to edit unity settings such as the hide behavior or bar size. <b>dconf-tools</b> too does it but not as user friendly as compizconfig. </div>
<div></div>
<div>3- Get rid of unwanted software. Install software that matter</div>
<div></div>
<div>I usually uninstall Ubuntu's game's suite, and libre office, because I use through my browser Google Docs, and install games through the chrome's appstore. </div>
<div></div>
<div>There are only 3 things that really matter. 1st is <a href="http://www.techronicles.net/2011/10/ubuntu-1110-chrome-chromium.html">my browser</a>, 2nd my <a href="http://www.techronicles.net/2011/10/ubuntu-1110-media-and-social.html">media</a> and <a href="http://www.techronicles.net/2011/10/ubuntu-1110-social.html">social setup</a>. 3rd is my <a href="http://www.techronicles.net/2011/10/ubuntu-1110-chrome-chromium.html">productivity suite</a> will discuss those in dept in other article. </div>
<div></div>
<div>4- Get back Synaptic Package Manager. </div>
<div></div>
<div>Ubuntu in 11.10 decided to only use their Software center as main way of installing applications. Although the center is better looking, for me it lacks some capabilities. </div>
<div></div>
<blockquote><p><span style="color:red;">sudo apt-get install synaptic</span></p></blockquote>
<div></div>
<div>5- This version of Ubuntu is pretty complete and comes with a lot of default options, the rest is really left at your discretion depending on what your computer is used for.</p>
<p>Just as an anecdote, I remember having to setup manually wireless and graphic card drivers in previous versions, at times we had to compile new kernels and apply patches from threads to make things work they way they should. Ubuntu has mature a lot and is more complete.</p>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/3ade2-hardware-tools-workshop-screwdriver-wrench-clip-art.jpg" style="margin-left:1em;margin-right:1em;"><img border="0" height="189" src="/images/wp/3ade2-hardware-tools-workshop-screwdriver-wrench-clip-art.jpg?w=300" width="200" /></a></div>
<p></div>
<div></div>
