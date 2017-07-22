---
layout: post
title: "Ubuntu Media"
date: 2011-10-15 01:58 -0400
categories:
- Multimedia
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '4428154505982042782'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<p><span style="font-size:large;">Media </span><br /><span style="font-size:large;"><br /></span><br />Media setup in ubuntu could mean many things, but I would like to quickly run through what I do to setup my media in Ubuntu.</p>
<p><b>1- Install ubuntu restricted extra</b><br />
<blockquote><span style="color:red;">sudo apt-get install ubuntu-restricted-extra</span></p></blockquote>
<p><b>2- Install VLC </b></p>
<p>VLC like a magic wand enables us to watch a lot of movies codecs, and is usally the pre-req for other applications, it is essential to install it early to get it out of the way.</p>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/ac543-vlc_media_player.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="100" src="/images/wp/ac543-vlc_media_player.png?w=256" width="100" /></a></div>
<p><b>3- Sopcast</b></p>
<p>I've previously<a href="http://www.techronicles.net/2009/10/sopcast-player-on-ubuntu.html"> covered sopcast</a>. in Ubuntu 11.10, the instructions are straight forward.</p>
<blockquote><p><span style="color:red;">sudo apt-add-repository ppa:jason-scheunemann/ppa<br />sudo apt-get update<br />sudo apt-get install sopcast-player </span></p></blockquote>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/10bab-50f72264483a1d9c1368bdb850548aca_icon25402x.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="100" src="/images/wp/10bab-50f72264483a1d9c1368bdb850548aca_icon25402x.png?w=112" width="100" /></a></div>
<p><b> 4- Other Services (Google Music Frame, Google Music Manager, Pithos) </b></p>
<p>Google Music Frame is a linux client for Google Music, it supports using the sound menu, to change tracks, notifications, and playlists. To install do the following</p>
<blockquote><p><span style="color:red;">sudo apt-add-repository ppa:janousek.jiri/google-music-frame-releases</span><span style="color:red;">sudo apt-get update</span><span style="color:red;">sudo apt-get install google-music-frame </span></p></blockquote>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/3e3f1-logo.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="100" src="/images/wp/3e3f1-logo.png?w=256" width="100" /></a></div>
<p><span style="color:red;"><br /></span><br />The weakness in Google Music Frame is that it doesn't support uploading of music. Google itself released a Music Manager that takes care of that. Here are the instructions on how to install</p>
<blockquote><p><span style="color:red;">Visit music.google.com and click 'Add Music' at the top right of the screen.</span><span style="color:red;">Click 'Download the Music Manager'</span><span style="color:red;">Select the appropriate package for your Linux distribution.</span><span style="color:red;">Install using your favorite package manager</span></p></blockquote>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/e80ac-google-music-logo.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="100" src="/images/wp/e80ac-google-music-logo.png?w=256" width="100" /></a></div>
<div class="separator" style="clear:both;text-align:left;"></div>
<div>Pithos is an application that brings pandora to linux, just like music frame it uses the best of linux OSD notifications and sound menu. It doesn't allow to creation of playlist but its a good desktop solution.
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/a5d3b-screenshot0-2.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="259" src="/images/wp/a5d3b-screenshot0-2.png?w=300" width="320" /></a></div>
<div class="separator" style="clear:both;text-align:left;"><b style="text-align:-webkit-auto;">5- Ubuntu Built-ins (Lense, Sound Menu)</b></div>
<div class="separator" style="clear:both;text-align:-webkit-auto;"><b><br /></b></div>
<div class="separator" style="clear:both;text-align:-webkit-auto;">On the top right, on the unity bar, there is a Ubuntu button that takes you into the options, this is the core of Unity interface. by typing your favorite artist, or by click the music icon on the bottom right, you can search your music gallery, when you select song, album or artist, it will take you right to your library and start playing it. </div>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/5a201-screenshotat2011-10-1609253a16253a06.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="360" src="/images/wp/5a201-screenshotat2011-10-1609253a16253a06.png?w=300" width="640" /></a></div>
<div class="separator" style="clear:both;text-align:-webkit-auto;"></div>
<div class="separator" style="clear:both;text-align:center;"></div>
</div>
<p>Ubuntu sound menu, we already talked about in the round up. Ubuntu used to have widgets we could add to the panel, and this way we<a href="http://www.techronicles.net/2009/05/gnome-music-applet-now-panflute.html"> could control music</a> without opening the application. Now Ubuntu by default has the sound menu, most music players support it. Banshee, Ubuntu's default Music player also uses it, and adds the elegant feature to select playlist right from this menu
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2011/10/a9789-menu_003.png" style="margin-left:1em;margin-right:1em;"><img border="0" id=":current_picnik_image" src="/images/wp/16285-16849368823_tchjp.jpg" /></a></div>
<p><b>6- Honorable Mentions  - Media Centers</b><br /><b><br /></b><br />There are Media Centers such as <a href="http://www.boxee.tv/">Boxee</a>, <a href="http://xbmc.org/">XMBC</a>, and <a href="http://www.getmiro.com/using-miro/">Miro</a>. In my previous setup, I used to install them, but they have not improved through the years as much as I would love them to. Will be installing them and trying them again, and will update if there's anything impressive that result from my research.</p>
