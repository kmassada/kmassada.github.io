---
layout: post
title: "[Linux Tip] Force install another version of an existing package RHEL6"
date: 2014-04-10 18:28:00.000000000 -04:00
categories:
- Linux Tip
tags: []
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '3229629812716420451'
  _edit_last: '7257748'
  geo_public: '0'
author:
  login: kmassada
  email: kmassada@gmail.com
  display_name: kmassada
  first_name: ''
  last_name: ''
excerpt: !ruby/object:Hpricot::Doc

---
<p>Originally recieved this error <b>error while loading shared libraries: libxml2.so.2: cannot open shared object file:</b><br />
<b><br />
</b>I have a missing library, so I decide to install it</p>
<blockquote class="tr_bq"><p>#yum install libxml2.so.2<br />
Setting up Install Process<br />
Resolving Dependencies<br />
--&gt; Running transaction check<br />
---&gt; Package libxml2.i686 0:2.7.6-14.el6 will be installed<br />
--&gt; Finished Dependency Resolution<br />
Error: Protected multilib versions: libxml2-2.7.6-14.el6.i686 != libxml2-2.7.6-14.el6.x86_64<br />
You could try using --skip-broken to work around the problem<br />
You could try running: rpm -Va --nofiles --nodigest</p></blockquote>
<div>of course I tried the default suggested steps <b>yum install libxml2.so.2 --skip-broken</b> and <b>rpm -Va --nofiles --nodigest</b></div>
<p>This file is linked to many items so I can't remove it,</p>
<blockquote class="tr_bq"><p>--&gt; Processing Dependency: libxml2.so.2(LIBXML2_2.4.30)(64bit) for package: libvirt-client-0.9.4-23.el6.x86_64</p></blockquote>
<p>Fix is  remove the package from the rpm database</p>
<blockquote class="tr_bq"><p># rpm -e --justdb --nodeps packagename<br />
# yum install libxml2.so.2 --skip-broken<br />
Setting up Install Process<br />
Resolving Dependencies<br />
--&gt; Running transaction check<br />
---&gt; Package libxml2.i686 0:2.7.6-14.el6 will be installed<br />
--&gt; Finished Dependency Resolution<br />
Dependencies Resolved</p></blockquote>
<blockquote class="tr_bq"><p>Install       1 Package(s)<br />
Total download size: 800 k<br />
Installed size: 1.7 M<br />
Is this ok [y/N]: y<br />
Downloading Packages:<br />
Running rpm_check_debug<br />
Running Transaction Test<br />
Transaction Test Succeeded<br />
Running Transaction</p></blockquote>
<div></div>
