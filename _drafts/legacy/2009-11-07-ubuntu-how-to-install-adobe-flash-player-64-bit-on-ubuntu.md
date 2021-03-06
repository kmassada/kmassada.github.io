---
layout:
title: "Ubuntu: How to Install Adobe Flash Player 64-bit on Ubuntu"
date: 2009-11-07 21:40 -0500
categories:
- Flash
- Multimedia
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '2798705125200546572'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<blockquote>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2009/11/1e503-download-flash-player-10-0-45-free.jpg" style="clear:left;float:left;margin-bottom:1em;margin-right:1em;"><img border="0" height="200" src="/images/wp/1e503-download-flash-player-10-0-45-free.jpg" width="200" /></a></div>
<p>On Karmic Koala, I realized that whenever i play videos on youtube, or do any interactions that requires flash to be working, It takes several clicks, to like for example click on play for youtube, or takes several clicks to advance a song on youtube, or sometimes, it might not even work. After following this tutorial, It fixed my problems</p>
<p><strong>WARNING: Close any opened window of the Firefox browser before you continue! Open this page in Opera, Epiphany or any other browser.</strong></p>
<p><strong>STEP 1 - Remove the 32-bit flash player</strong></p>
<p>You must remove the existing installation of the 32-bit flash player before installing the 64-bit one. Go to <em>System -&gt; Administration -&gt; Synaptic Package Manager</em>...</p>
<p>When Synaptic is ready, just type "nsplugin" (without quotes) in the search box. It will immediately find the package. Click on the green box in front of the "nspluginwrapper" package, and select the "Mark for Complete Removal" option...</p>
<p>You will also be notified about the removal of the "flashplugin-nonfree" package. Click on the "Mark" button...</p>
<p>Now, click on the "Apply" button; a confirmation window will appear, click "Apply," and wait for the packages to be removed from your system. Close Synaptic when it finishes the removal of the 32-bit flash player packages.<br /><strong><br />STEP 2 - Install the 64-bit flash player</strong><br /><a href="http://labs.adobe.com/downloads/flashplayer10.html">http://labs.adobe.com/downloads/flashplayer10.html </a>[11/07/2009]<br />Extract the archive of the 64-bit flash player and you will end up with a "libflashplayer.so" file...</p>
<p>Now, open your Home folder, go to <em>View -&gt; Show Hidden Files</em> to view the hidden files...</p>
<p>Enter the .mozilla folder and create a new directory called "plugins" (without quotes). Drag and drop the "libflashplayer.so" file from the desktop to the "plugins" folder...</p>
<p><strong>STEP 3 - Verify the installation of the 64-bit flash player</strong></p>
<p>You can safely open the Firefox web browser, and go to YouTube or any other website with flash content. Try to watch a movie. Eureka! It works!</p></blockquote>
<p><span style="color:olive;"><strong>When Lucid was released immediately, the instructions that i'm about to provide works, and still do (6/22/10) the only issue is that adobe discontinued 64 bit flash player for the moment, so we are not more getting updates.</strong></span><br />
<blockquote>Add the PPA via a terminal using</p>
<p><strong>sudo add-apt-repository  ppa:sevenmachines/flash</strong><strong><br /></strong><br /><strong> </strong><br />
<h3>   Install</h3>
<p>You may then proceed with installation by searching for or  typing: -</p>
<p><strong>sudo apt-get update &amp;&amp; sudo apt-get install  flashplugin64-installer</strong></p></blockquote>
<p><strong><span style="color:olive;">Since Adobe discontinued their flash for 64 bit, there are several people that wrote scripts to attempt to update flash, and here is one of them that worked.  Note both method do the same thing and install the same versions 10.0.45.2. </span></strong><br />
<blockquote>By default, the Flash player in the repositories is a 32-bit version of Flash. This version does not work properly on 64-bit installations of Ubuntu 10.04.<br />Someone made a bash script to automate the process of installing Flash Player 10 to Ubuntu. All you have to do is to type or copy-paste the following in the Terminal (Applications -&gt; Accessories -&gt; Terminal):<br /><code>wget http://conradmiguel.com/install-flash.sh<br />chmod +x install-flash.sh<br />./install-flash.sh</code><br />It will ask for your password. Just provide your password. Restart Firefox and enjoy your Flash Player 10!</p></blockquote>
<p><span style="color:#6fa8dc;"><br /></span><b><span style="color:#6fa8dc;">(9/30/2011) Update: Adobe re-enabled their beta and keeps updating flash, enabling the ppa for sevenmachines is still a good way of getting the latest driver. Also note, back when I wrote this tutorial I was using Firefox, Now I switched to chrome, which comes with its own pre-loaded flash drivers.  </span></b></p>
