---
layout: single
title: "Access All your Home Network Everywhere"
date: 2012-12-16 20:30 -0500
categories: [Android, Network, Staff Picks]
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '3368226676448923996'


excerpt_separator: <!--more-->

---
<p>There are a million solutions for accessing files from home Dropbox for files to sync in the cloud, Google Play Music for your music, TeamViewer for viewing your computer, and Chrome syncs all your bookmarks on the go. All started when I thought, I wanted to be able to access everything, just the way they are at home? Here's How?
<div></div>
<div>When you are beginning these are things people wonder, but never ask. </div>
<div></div>
<div class="separator" style="clear:both;text-align:center;"><a href="#" style="margin-left:1em;margin-right:1em;"><img border="0" src="/assets/images/wp/7902f-home-network.jpg" /></a></div>
<div>Its all about concepts here, you need realize that you get a <b>DHCP</b> lease from you <b>Service provider</b>, when you google, "my public IP" you get a funny IP, that's from your ISP. Depending on your location, that <b>IP changes</b>, every time router reboots. You can also tie that IP to a <b>domain name (funny-name.com)</b>, using a <b>Dynamic DNS</b> provider. Here's a Free one: <a href="http://www.dnsdynamic.org/">http://www.dnsdynamic.org/</a>. These Providers tie your IP to a name you can use, instead of having to always enter a public IP. And since your IP can change, I know of people whose never changed in 10 years. But there are solutions to update your IP:  <a href="https://help.ubuntu.com/community/DynamicDNS">Ubuntu Dynamic DNS</a>  and <a href="http://www.ubuntugeek.com/update-ip-addresses-at-dynamic-dns-services-using-ddclient.html">update your ip using ddclient</a> . These days, routers like ASUS will offer you a Dynamic DNS service name, and updating your IP for free. For asus its .asuscomm.com. </div>
<div></div>
<div>Now that we got that part sorted. When All the requests come to your Router, it need to know what to do with it. First of all the requests come through <b>Protocols</b> and <b>Ports, </b> now your router takes in all those requests, but you can forward them to the different machines on your network  <a href="http://www.wikihow.com/Set-up-Port-Forwarding-on-a-Router">Setup Port Forwarding on a Router</a> through a concept called <b>PORT FORWARDING, </b>my first post will be on Openvpn, it uses port 1194, so you open the port from your router to 1194 on the server. [Be clever] you can actually open port 84565 and forward it to 65653, I'll elaborate more on security soon. </div>
<div></div>
<div>LifeHacker also has a wonderful post on this topic. <a href="http://lifehacker.com/5797582/how-to-turn-your-computer-into-the-ultimate-remote-access-media-server">Turn your computer into ultimate remote access server</a> </div>
<div></div>
<div>A lot of the concepts I talk about follow this logic, I needed to quickly talk about it, in some way so I can tackle real posts. Cheers if it is of some help to someone out there.</div>
<div></div>
<div></div>
