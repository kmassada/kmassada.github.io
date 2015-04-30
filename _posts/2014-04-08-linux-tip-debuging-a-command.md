---
layout: post
title: "[Linux Tip] debuging a command"
date: 2014-04-08 18:53:00.000000000 -04:00
categories:
- Linux Tip
tags: []
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '5009630149509698019'
  _edit_last: '7257748'
  _oembed_70b27b65e33c93ac3086b93e513a7780: "{{unknown}}"

excerpt: !ruby/object:Hpricot::Doc

---
<p>this is very useful when you are running a script that calls other scripts.
<div></div>
<blockquote class="tr_bq"><p># set -x<br /># ls<br />+ ls --color=auto<br />anaconda-ks.cfg  install.log  install.log.syslog<br />++ printf '33]0;%s@%s:%s33\' root kmassada '~'</p></blockquote>
<div></div>
<p> <b> -x Print commands and their arguments as they are executed.</b></p>
<p>Another indepth tool is strace. it logs all of the system calls made. it is a very verbose and useful way to see what is happenening on your shell</p>
<blockquote class="tr_bq"><p># strace -t ls<br />14:52:02 execve("/bin/ls", ["ls"], [/* 29 vars */]) = 0<br />14:52:02 brk(0)                         = 0x2244000<br />14:52:02 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fd643d18000<br />14:52:02 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)<br />14:52:02 open("/etc/ld.so.cache", O_RDONLY) = 3<br />14:52:02 fstat(3, {st_mode=S_IFREG|0644, st_size=87611, ...}) = 0<br />14:52:02 mmap(NULL, 87611, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fd643d02000<br />14:52:02 close(3)                       = 0</p></blockquote>
<blockquote class="tr_bq"><p>.... </p></blockquote>
<p><b>    -t Shows time of the day </b></p>
