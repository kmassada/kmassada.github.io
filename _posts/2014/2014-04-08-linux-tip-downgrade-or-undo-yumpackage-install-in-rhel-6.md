---
layout: single
title: "[Linux Tip] downgrade or undo yum/package install in RHEL 6"
date: 2014-04-08 19:13 -0400
categories: [Linux Tip]
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '1974829809749011319'
  _edit_last: '7257748'
  _oembed_ba5d68c3c78752e5bc4ff79cac6a0112: "{{unknown}}"


excerpt_separator: <!--more-->

---
<p> downgrade or undo yum/package install in RHEL 6 is fairly straight forward</p>
<blockquote class="tr_bq"><p># yum history<br />ID | Login user | Date and time | Action(s) | Altered<br />-------------------------------------------------------------------------------<br />1 | root | 2014-04-07 21:21 | Downgrade | 3</p></blockquote>
<blockquote class="tr_bq"><p></p></blockquote>
<p>now if you do</p>
<blockquote class="tr_bq"><p># yum -y history undo 1</p></blockquote>
<p>it reverts your changes made in 1. sommetime, you have to run it with --skip-broken if it cannot resolve a dependency and run it couple of times to make sure the packages requested get removed.</p>
<p>Much more efficient than <a href="https://access.redhat.com/site/solutions/186763" target="_blank">Red Hat's Recommended method to downgrade </a> OS versions</p>
