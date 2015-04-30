---
layout: post
title: "[Linux Tip] Finding what is using up space in your drive"
date: 2014-03-21 13:52:00.000000000 -04:00
categories: [Linux Tip]
tags: []
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '7976022902269024845'
  _edit_last: '7257748'

excerpt: !ruby/object:Hpricot::Doc

---
<p>In linux, you have the usual tools <b>(fdisk -l)</b> tells you what drives are present and partitions and this tells you what partitions are mounted where<b> (df -h)</b>, but after that it's not pleaseant task to find missing space, I've seen folks use ls for it.</p>
<p>Quick tip: <b>du -h</b> gives you folders and their human readable sizes.<b> sort -rn </b>sorts them by category, K, M, G<br />
<blockquote class="tr_bq"># du -h /root/ | sort -rn<br />180K    /root/.gconf<br />156K    /root/.gconf/apps</p></blockquote>
<div></div>
