---
layout: post
title: "Ubuntu: Makes Newer Ubuntu Apps Easily Available (GetDeb.Net Repository)"
date: 2009-11-21 12:46:00.000000000 -05:00
categories:
- Repositories
- Tools and Utilities
tags: blogger
status: draft
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '1318995598575528291'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<blockquote>1. Install the getdeb package. </p></blockquote>
<blockquote><p>2. Or configure the repository manually: Go to System-Administration-Software Sources, Third-Party Software tab, Add: <strong><code>deb http://archive.getdeb.net/ubuntu karmic-getdeb apps</code></strong> Add the repository GPG key, open a terminal window and type: <strong><code>wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -</code></strong> </p></blockquote>
<blockquote><p>3.Click the "Install this now" button below the screenshot of the desired application.</p></blockquote>
<p>This method took care of updating some applications such as Empathy, Frostwire, Transmission and many others.</p>
<p><span style="color:red;"><strong>How to add getdeb repository in after  Ubuntu 10.04</strong></span><br />
<blockquote>Go to System-Administration-Software Sources, Third-Party Software tab, Add: <strong>deb http://archive.getdeb.net/ubuntu lucid-getdeb </strong><a href="http://www.ubuntugeek.com/getdebplaydeb-ubuntu-10-04-lucid-lynx-repository-available-now.html#" target="_blank"><strong>apps</strong></a> Add the repository GPG key, open a terminal window and type: <strong>wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -</strong></p></blockquote>
<p></p>
