---
layout: single
title: "Ntfs mount permissions on linux"
date: 2014-06-21 10:22 -0400
categories: [File System, Linux Tip, System Admin]
tags: linux mount  ntfs  partitions
status: publish
type: post
published: true
meta:
  geo_public: '0'
  _edit_last: '7257748'
  _wpas_skip_path: '1'
  _publicize_pending: '1'
  _wpas_skip_linkedin: '1'
  _wpas_skip_twitter: '1'
  _wpas_skip_google_plus: '1'
  _wpas_skip_tumblr: '1'
  _wpas_skip_facebook: '1'

excerpt_separator: <!--more-->

---
<p>If you stumble upon this, you are probably trying to mount ntfs on linux, or have tried to change folder or file permissions but they remain the same. Or you have gone through tutorials for mounting your NTFS partition, created it with your user and group, but it remains root and plugdev. The answer you are looking for is simple</p>
<blockquote><p><strong>There are no Linux ownership or permission bits in an NTFS file system. </strong></p></blockquote>
<p>The process is the following</p>
<p><code>$ sudo mkdir /Kenneth<br />
$ sudo chown ken:kengroup /Kenneth<br />
$ sudo chmod 755 -R /Kenneth<br />
</code><br />
Now you find the uuid of the device by running</p>
<p><code>$ sudo blkid<br />
/dev/sda6: UUID="HEXDECIMALNUMBER" TYPE="ntfs"</code></p>
<p>let's also find your user id, you might need it</p>
<p><code>$ id<br />
uid=1000(ken) gid=1000(kengroup)</code></p>
<p>Now we edit the fstab so you can mound during boot</p>
<p><code>$ sudo vi /etc/fstab<br />
UUID=HEXDECIMALNUMBER       /Kenneth        ntfs-3g    defaults,uid=1000,gid=1000,umask=022 0       2</code></p>
<p>this is simple, we are only allowing uid of ken, and gid of kengrp to have exclusive rights to the drive with the umask value of 022 ie default access permission for your files of 664 (rw-rw-r--) and for your directories of 775 (rwxrwxr-x)</p>
<p>now that this is edited, you can simply mount by doing</p>
<p><code>$ sudo mount -a<br />
$ ls -ld /Kenneth/<br />
drwxrwx--- 1 root plugdev 20480 Jul 20 17:31 /Kenneth/</code></p>
