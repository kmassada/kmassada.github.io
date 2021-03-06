---
layout: single
title: "Ubuntu: Mounting ext3/ext4 Partitions"
date: 2009-03-18 16:10 -0400
categories: [File System, Tools and Utilities]
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '5617978437888682041'


excerpt_separator: <!--more-->

---
<p>Since I went ahead and got rid of my windows, my partition is strictly just ext3 files. The problem, I encountered was that the partition will not automount. Here I describe the steps taken to fix it.</p>
<p>1- Installed the GParted Software that helps set partitions<br />
<blockquote><strong>sudo apt-get install gparted</strong></p></blockquote>
<p>2- Allocated the space required to my drive, and assigned it to ext3/ext4</p>
<p>3- Using the terminal to find out what the uid for the drive i want to automount<br />
<blockquote><strong>sudo blkid</strong></p></blockquote>
<p>4- Create where you want that partition to be mount<br />
<blockquote><strong>sudo mkdir /path to whatever<br /><span style="font-weight:normal;"> ex: sudo mkdir /Kenneth</span></strong></p></blockquote>
<p>5-edited my fstab by<br />
<blockquote><strong>sudo gedit /etc/fstab</strong></p>
<p>line reads: # /dev/sa7  UUID=uid obtained by blkid /Kenneth ext3 errors=remount-ro 0 0</p>
<p>for that to take effect in terminal run: <strong>sudo mount -a</strong></p></blockquote>
<p>6- Gave my self Admin rights<br />
<blockquote><strong>sudo nautilus</strong><br />then right click drive and then click on properties to grant myself admin rights at all times</p></blockquote>
