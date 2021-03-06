---
layout:
title: "Ubuntu: SopCast Player on Ubuntu"
date: 2009-10-25 16:31 -0400
categories:
- Multimedia
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '3960531349082793579'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<p>Being a huge soccer fan, the only way i know for watching soccer games online is by using sopcast.</p>
<p>First install the software<br />
<blockquote>Sopcast Internet TV</p>
<p>Sopcast is an interface to play live P2P video streams through the VLC media player. Install VLC first. This is a Chinese program and most content is hosted in China and may not be legal in your area. Please consult local regulations.</p>
<p>Download and install:</p>
<p><strong>wget http://sopcast-player.googlecode.com/files/sp-auth_3.0.1_i386.deb<br />wget http://sopcast-player.googlecode.com/files/sopcast-player_0.3.0-0ubuntu1_i386.deb<br />sudo dpkg -i sp-auth_3.0.1_i386.deb sopcast-player_0.3.0-0ubuntu1_i386.deb</strong></p>
<p>For 64-bit systems, use:</p>
<p><strong>wget http://sopcast-player.googlecode.com/files/sp-auth_3.0.1_amd64.deb<br />wget http://sopcast-player.googlecode.com/files/sopcast-player_0.3.0-0ubuntu1_amd64.deb<br />sudo dpkg -i sp-auth_3.0.1_amd64.deb sopcast-player_0.3.0-0ubuntu1_amd64.deb</strong></p>
<p>Run:</p>
<p>Applications-&gt;Sound &amp; Video-&gt;SopCast Player</p></blockquote>
<p>2- set firefox to recognize the .sop protocol. This step is so that when you click on a link in ffox, you can get the application to open immediately. If you don't use ffox, just right click on the sop link and copy it.<br />
<blockquote>On Firefox address bar, enter:<strong> about:config</strong><br />Right click, select new and string.<br />Set string name to:<strong> network.protocol-handler.app.sop</strong><br />Set value to:<strong> /usr/bin/sopcast-player</strong></p></blockquote>
<p>3- The website for the Soccer games</p>
<p>goto <strong>http://www.myp2p.eu</strong><br />click on live sports<br />then click on the soccer ball<br />click on the tv icon to the game of your choice<br />then a list will show up with different places where you can watch the game<br />click on the sop one, and the application should open<br />None Firefox users/who couldn't get the protocol to work<br />(right click on the link copy it, got to the soap application<br />File&gt;Open then paste the url)</p>
<p>[gallery]</p>
<p>*technique proposed in one of the comments. Note SopCast barely updates its PPA, so that technique is really not that different from the one at the beginning of the post<br />
<blockquote>or you could install it using a PPA</p>
<p>Use the following command to add the sopcast player PPA</p>
<p><code><strong>sudo add-apt-repository ppa:jason-scheunemann/ppa</strong></code></p>
<p>Update the source list using the following command</p>
<p><code><strong>sudo apt-get update</strong></code></p>
<p>First you need to install sp-auth .deb package so download from here</p>
<p><code><strong>wget http://sopcast-player.googlecode.com/files/sp-auth_3.0.1_i386.deb</strong><br />or<br /><strong> wget http://sopcast-player.googlecode.com/files/sp-auth_3.0.1_amd64.deb</strong></code></p>
<p>Install .deb package</p>
<p><code><strong>sudo dpkg -i sp-auth_3.0.1_i386.deb</strong><br />or<br /><strong> sp-auth_3.0.1_amd64.deb</strong></code></p>
<p>Install sopcast player using the following command</p>
<p><code><strong>sudo apt-get install sopcast-player</strong></code></p>
<p>or click on the following link to install</p>
<p><code><strong>apt://sopcast-player</strong></code></p></blockquote>
<p><strong><span style="color:olive;">In Lucid, its the same instructions for the install, but to associate firefox with the SOP protocol, its a little different, follow these instructions instead.</span></strong><br />
<blockquote>To configure your Firefox to open “<em><strong>sop://</strong></em>” link automatically in Sopcast Player:</p>
<p>1. Type <em><strong>about:config</strong></em> in the address bar.</p>
<p>2. Click the button “I’ll be careful, I promise!”</p>
<p>3. Right click anywhere on the screen and select “<em><strong>New -&gt; String</strong></em>”</p>
<p>4. Enter “<em><strong>network.protocol-handler.app.sop</strong></em>” (without the quote) in the preferences name</p>
<p>5. Enter “<em><strong>/usr/bin/sopcast-player</strong></em>” as the value.</p>
<p>6. If you are using Firefox 3.6 and above, you need to change the value of “<em><strong>network.protocol-handler.expose-all</strong></em><strong>” to “</strong><em><strong>false</strong></em>”</p>
<p>Now, when you click on the sop:// link, a window will open and prompt you for the <a href="http://maketecheasier.com/install-sopcast-in-ubuntu/2010/06/10#" id="KonaLink1" target="undefined"><span style="color:blue;">application</span></a>to open the link. Navigate to /usr/bin/sopcast-player. remember to check the box “remember my choice for sop link”.</p>
<p>Whenever you open a sopcast link, it will automatically open in sopcast player.</p></blockquote>
<p><b><span style="color:#3d85c6;">(9/30/2011) Update: in Natty Narwhal here is the easy way to install Sopcast. </span></b><br />
<blockquote><strong style="font-family:'UbuntuBeta Regular', Ubuntu, 'Bitstream Vera Sans', 'DejaVu Sans', Tahoma, sans-serif;font-size:12px;font-weight:bold;line-height:18px;text-align:left;">sudo apt-add-repository ppa:jason-scheunemann/ppa</strong><strong style="font-family:'UbuntuBeta Regular', Ubuntu, 'Bitstream Vera Sans', 'DejaVu Sans', Tahoma, sans-serif;font-size:12px;font-weight:bold;line-height:18px;text-align:left;">sudo apt-get update</strong><strong style="font-family:'UbuntuBeta Regular', Ubuntu, 'Bitstream Vera Sans', 'DejaVu Sans', Tahoma, sans-serif;font-size:12px;font-weight:bold;line-height:18px;text-align:left;">sudo apt-get install sopcast-player </strong></p></blockquote>
<p><b><span style="color:#3d85c6;">It works also in Oneiric Ocelot, but there is a little bug. </span></b><br /><b><span style="color:#3d85c6;">Sopcast never opens, if you run sopcast on a command line, </span></b></p>
<p>
<blockquote><span style="color:red;">abc@xyz$ sopcast-player </span><span style="color:red;"><br /></span><span style="color:red;">(sopcast-player.py:312): Gtk-WARNING **: Unable to locate theme engine in module_path: "pixmap",</span><span style="color:red;"><br /></span><span style="color:red;">(sopcast-player.py:312): Gtk-WARNING **: Unable to locate theme engine in module_path: "pixmap",</span><span style="color:red;"><br /></span><span style="color:red;">(sopcast-player.py:312): Gtk-WARNING **: Unable to locate theme engine in module_path: "pixmap",</span><span style="color:red;"><br /></span><span style="color:red;">(sopcast-player.py:312): Gtk-WARNING **: Unable to locate theme engine in module_path: "pixmap",</span><span style="color:red;">Segmentation fault (core dumped)</span></p></blockquote>
<div><b><span style="color:#3d85c6;">a quick fix is to: </span></b></div>
<div><b><span style="color:#3d85c6;"><br /></span></b></div>
<div><b><span style="color:#3d85c6;">cd /usr/share/sopcast-player/lib/</span></b></div>
<div><b><span style="color:#3d85c6;">sudo gedit VLCWidget.py</span></b></div>
<div><b><span style="color:#3d85c6;">Look for <span style="background-color:white;font-family:monospace;font-size:12px;white-space:pre-wrap;">import vlc_1_0_x </span>and add # at the beginning of that line</span></b></div>
<p>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2009/10/c0f41-screenshotat2011-10-0102253a55253a31.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="228" src="/images/wp/c0f41-screenshotat2011-10-0102253a55253a31.png?w=300" width="320" /></a></div>
<div></div>
<p></p>
