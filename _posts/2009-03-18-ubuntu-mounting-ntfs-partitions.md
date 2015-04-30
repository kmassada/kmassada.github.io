---
layout: post
title: 'Ubuntu: Mounting NTFS Partitions'
date: 2009-03-18 13:26:00.000000000 -04:00
categories:
- File System
- Tools and Utilities
tags: []
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '8592956711151015826'

excerpt: !ruby/object:Hpricot::Doc

---
<blockquote>Ubuntu 8.10 (Intrepid Ibex) and Ubuntu 8.04 LTS (Hardy Heron)</p>
<p>The ntfs-3g packages comes pre-installed with the newest versions of Ubuntu, but you still need to install ntfs-config if you want the GUI configuration tool. You can search for "ntfs-config" in Synaptic or install via terminal:</p>
<p><strong>sudo apt-get install ntfs-config</strong>
<div class="line874">Now you have the choice between an automatic configuration using ntfs-config or a manual configuration.</div>
<p>
<div class="line867"></div>
<h2>The Automatic Way</h2>
<p>
<div class="line867">Launch <strong>NTFS Configuration Tool</strong> from Applications-&gt;System Tools, or via the terminal:</div>
<pre>gksudo ntfs-config</pre>
<p>
<div class="line867"><span id="goog_423286"></span><span id="goog_423289"></span><img alt="ntfs-config.png" class="attachment" id=":current_picnik_image" src="/images/wp/5863a-16606044586_qvwkt.jpg" title="ntfs-config.png" /><span id="goog_423290"></span><span id="goog_423287"></span></div>
<p>
<div class="line874">If you have at least one internal NTFS partition, it will allow you to check both boxes, otherwise you can only check the box for external devices.</div>
<p>If your NTFS partition(s) are not yet configured, it will ask you to choose a name that will be used as the mount point (please no spaces). Then enable write support for internal and/or external devices</p></blockquote>
<p>For the Manual way, you can refer to mountingWindows <a href="https://help.ubuntu.com/community/MountingWindowsPartitions/ThirdPartyNTFS3G">NTFS PARTITION official guide by Ubuntu</a></p>
