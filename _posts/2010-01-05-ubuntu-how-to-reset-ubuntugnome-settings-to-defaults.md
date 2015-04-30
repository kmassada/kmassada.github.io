---
layout: post
title: 'Ubuntu: How to Reset Ubuntu/Gnome Settings to Defaults'
date: 2010-01-05 17:41:00.000000000 -05:00
categories: [compiz, Eye Candy, Tools and Utilities, Ubuntu]
tags: []
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '7924761030817032822'

excerpt: !ruby/object:Hpricot::Doc

---
<div class="separator" style="clear:both;text-align:center;"></div>
<p>In a terminal, run the command below:
<div>
<blockquote>rm -rf .gnome .gnome2 .gconf .gconfd .metacity</p></blockquote>
</div>
<p>Other Fixes<br />1- You are most likely going to get the following error: "The application 'NetworkManager Applet' (/usr/bin/nm-applet) wants access to the default keyring, but it is locked." 
<div></div>
<p>to fix it its simple, here is how i did it<br />
<blockquote>I right clicked the wireless applet, went to 'edit connections', the wireless tab, and checked the "available to all users" for our wireless connection. Rebooted and it logged in and wireless was already connected. No password prompts.</p></blockquote>
<p>2- Screenlet won't stay on desktop when I minimize all windows<br />
<blockquote>start gconf-editor and uncheck this value: /apps/compiz/general/allscreens/options/hide_skip_taskbar_windows</p></blockquote>
<p>3- Compiz settings disappear<br />Reset them, or make a backup of your compiz settings folder. (NOT RECOMMENDED)</p>
<p><span>(06/22/2010) I have yet to find an app, or an efficient way to simply reset my desktop, leave the apps the way they are but just clean up all the configs and settings, and thus far this is the closest i get.</span>
<div><span><br /></span></div>
<div><span>(09/30/2011) There is an application called <a href="http://bleachbit.sourceforge.net/">BleachBit</a> that will allow you to clean up settings, cache, data etc, but doesn't clean up app settings inside gconf or gconfd in your home folder</span></div>
