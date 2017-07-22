---
layout: post
title: "Ubuntu: Graphics Card Setup"
date: 2009-03-17 16:15:00.000000000 -04:00
categories:
- Graphic Card
- Tools and Utilities
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '4688203909624419142'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<p>Hello, Setting up graphic cards can be very tedious and there could a whole bunch of challenges in it.  Here are  couple of things that helped me. I Didn't update the Linux headers. There has been a bug reported with the most recent headers in Intrepid, don't know if it has been fixed already. But until then I stick with the original headers for intrepid.</p>
<p><strong>ENVY-NG</strong><br />install the envy-core package using either the synaptic package manager, or the command (sudo apt-get install envyng-core)</p>
<p>after the install, you can select the options to install the card that is recommended for your video card.</p>
<p><strong><br /></strong></p>
<p><strong>Hardware Drivers</strong><br />If you click on System&gt;Administration&gt;Hardware Drivers, you can select and install the driver that pretends to your card.</p>
<p><strong><strong>Community</strong></strong>If you are not able to install your card after couple of attempts, you could search your card name, how to find it (in the command line type "lspci", go down the list, looking for VGA Controller) and then look for threads that concern your card. It's really helpful</p>
<p><strong>How you know when your card works properly?</strong> That's when on the start up page doesn't look weird, it becomes so obvious, by the rendering of the pages.</p>
<p><strong>If you mess up?</strong> when you reboot, in your grub, select the recovery mode, and select the xfix, rolls you back to the standard version.</p>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2009/03/17803-screenshot-hardware-drivers1.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="400" src="/images/wp/17803-screenshot-hardware-drivers1.png?w=270" width="360" /></a></div>
<p><span style="color:olive;"><strong>*Update (5/18/2009): On Jaunty Jackalope the process is simpler, If you click on System&gt;Administration&gt;Hardware Drivers, you can select and install the driver that pretends to your card.</strong></span></p>
<p><span style="color:olive;"><strong>*Update (11/01/2009): From Karmic, Lucid on, the driver installs automatically.  You can still select the hardware using the instructions above, but once you get there you'll realize that ubuntu will have installed the latest drivers. </strong></span></p>
