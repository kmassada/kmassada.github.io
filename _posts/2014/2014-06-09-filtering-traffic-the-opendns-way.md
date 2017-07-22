---
layout:
title: "Filtering Traffic: The OpenDNS way"
date: 2014-06-09 15:49 -0400
categories: [Home]
tags: blogger
status: publish
type: post
published: true
meta:
  _edit_last: '7257748'
  _publicize_pending: '1'
  geo_public: '0'
  _wp_old_slug: filtering-traffic-the-dns-way


excerpt_separator: <!--more-->

---
<p>The classic problem, someone connects to your wi-fi, and tries to download a movie, then you get a nasty email from your ISP making you look like an organized crime ring lord.</p>
<p>what you looking for is a traffic filtering solution</p>
<p>I used to have a complicated routing table blocking every known p2p site, known to man. Then I switched to creating my own  <strong>DansGuardian</strong>/<strong>pfsense</strong> implementation. After moving, I lost all the configs, and had to settle for <strong>OpenDNS</strong>, which is a very good solution, direct solution.</p>
<p>The setup is easy.</p>
<p>1- change your dns servers on your broadband network, not local network.</p>
<p>Your gateway IP is on the router, with the password. A common one is http://192.168.1.1/</p>
<p>go into Network connections,</p>
<p><a href="https://techronilces.files.wordpress.com/2014/06/centernetworkconnec_0f18.jpg"><img class="alignnone size-medium wp-image-323" src="/assets/images/wp/centernetworkconnec_0f18.jpg?w=300" alt="centernetworkconnec_0f18" width="300" height="134" /></a></p>
<p>and point your DNS servers to OpenDNS servers</p>
<ul>
<li>208.67.222.222</li>
<li>208.67.220.220</li>
</ul>
<p><a href="https://techronilces.files.wordpress.com/2014/06/vzmi424wr_dns_7af5.jpg"><img class="alignnone size-medium wp-image-324" src="/assets/images/wp/vzmi424wr_dns_7af5.jpg?w=300" alt="vzmi424wr_dns_7af5" width="300" height="103" /></a></p>
<p>2- setup your openDNS account. go to OpenDNS.com the setup is as easy as creating an email address.</p>
<p>you'll be asked to provide your public IP. A simple google search "what's my ip" will give you that information</p>
<p>OpenDNS now can configure filters on your behalf. Summary: your DNS points to OpenDNS, which in returns knows yout ip, and filters content based on your requests. It's that simple.</p>
<p>you can select pre-configured filters, or select your own custom ones.</p>
<p>&nbsp;</p>
<p><a href="http://techronilces.files.wordpress.com/2014/06/contentfilter.png"><img class="alignnone wp-image-325 size-large" src="/assets/images/wp/contentfilter.png?w=640" alt="" width="640" height="372" /></a></p>
<p>&nbsp;</p>
<p>and on a good day, you block, your targets.</p>
<p><a href="http://techronilces.files.wordpress.com/2014/06/antcom.png"><img class="alignnone wp-image-326 size-large" src="/assets/images/wp/antcom.png?w=640" alt="" width="640" height="547" /></a></p>
