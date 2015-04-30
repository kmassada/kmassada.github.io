---
layout: post
title: 'Ubuntu: TOR (Proxy Servers)'
date: 2009-07-02 16:16:00.000000000 -04:00
categories:
- proxy
- Tools and Utilities
tags: []
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '6071373287496069448'
author:
  login: kmassada
  email: kmassada@gmail.com
  display_name: kmassada
  first_name: ''
  last_name: ''
excerpt: !ruby/object:Hpricot::Doc

---
<p><a href="#" style="clear:left;float:left;margin-bottom:1em;margin-right:1em;"><img border="0" height="171" src="/images/wp/9ac2d-go-online-without-getting-snooped-tor-the-onion.jpg?w=300" width="200" /></a>Oki this came to my attention, when I started following the crisis in Iran and was wondering how they did to bypass their government firewalls to keep the story alive in the states... This is also a quick tutorial on how to use Proxy.</p>
<p>1. Run the command: <strong>sudo apt-get install tor privoxy</strong><br />2. Run the command: <strong>sudo gedit /etc/privoxy/config</strong><br />3. Add the line (including the period at the end): <strong>forward-socks4a / localhost:9050 .</strong><br />4. Comment out the line: <strong>logfile logfile</strong> (you know with the "#")<br />5. Comment out the line: <strong>jarfile jarfile</strong> (you know with the "#")<br />6. Restart the Privoxy service:<strong> sudo /etc/init.d/privoxy restart</strong></p>
<p>How to set up Firefox to work with Tor:</p>
<p>1. Install the torbutton extension.<br />2. Restart Firefox<br />3. In the bottom right corner you’ll have a text blurb saying: Tor Disabled</p>
<p>run:</p>
<p><strong>-sudo /etc/init.d/privoxy restart</strong></p>
<p><strong>-sudo /etc/init.d/tor restart</strong></p>
<p><strong></strong><br />4. Enable Tor by clicking the blurb; it should say: Tor Enabled<br />5. Surf the web</p>
<p>To make sure it works try this <a href="https://check.torproject.org/">https://check.torproject.org/</a></p>
<p>~<a href="http://www.torproject.org/docs/tor-doc-unix.html.en">Tor Official Website</a> (includes repository for tor and privoxy)</p>
<p>~<a href="https://wiki.torproject.org/noreply/TheOnionRouter/TorifyHOWTO">The full Wiki Page</a></p>
<p>GOOD LUCK!</p>
<p><strong><span style="color:olive;">You can also install an application called vidalia, its a TOR manager, that lets you turn the connections on and off,  Its just basically a GUI version of the commands.</span></strong><br /><strong><span style="color:olive;"><br /></span></strong><br /><strong><span style="color:olive;"><br /></span></strong></p>
