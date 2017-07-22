---
layout: post
title: "Ubuntu: Cairo Dock, Compiz, Emerald"
date: 2009-03-17 18:03 -0400
categories:
- compiz
- Eye Candy
- Productivity
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '283084723953665588'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<p><strong>Cairo-dock :</strong> I had a bad experience with almost all other ubuntu dock, after several tests, i decided to stick with Cairo dock.<br />
<blockquote>
<h3>  Installation</h3>
<p>
<div class="line874">The project is split in to two parts: the dock itself and the plug-ins. Only the installation of the dock is explained, but installing the plug-ins is the same, just make sure you install the plug-ins after the dock.</div>
<p>
<div class="line874">The config file will not be overwritten during updates as Cairo-Dock is capable of inserting the missing fields if any without losing your previous settings.</div>
<p>
<div class="line874">Please note that, although Cairo-Dock is listed in the Universe repository since Ubuntu 8.10 (Intrepid Ibex) and can be installed using Synaptic Package Manager, it is recommended to install Cairo-Dock using one of the methods described below to get the most up-to-date and stable version of Cairo-Dock.</div>
<p>
<div class="line867"></div>
<h2>  From the Repository (Stable)</h2>
<p>
<div class="line874">This is only for Ubuntu 7.10 (Gutsy Gibbon) 32 bit, Ubuntu 8.04 (Hardy Heron) 32/64bit and Ubuntu 8.10 (Intrepid Ibex) 32/64bit.</div>
<p>
<div class="line874">To add the Cairo-Dock repository to your sources open the sources.list file:</div>
<p>
<div class="line867"></div>
<pre>sudo gedit /etc/apt/sources.list</pre>
<p>
<div class="line874">and add the appropriate repository to the end of the file:</div>
<p>
<div class="line867"></div>
<pre>deb http://repository.cairo-dock.org/ubuntu intrepid cairo-dock<br /><br />deb http://repository.cairo-dock.org/ubuntu hardy cairo-dock<br /><br />deb http://repository.cairo-dock.org/ubuntu gutsy cairo-dock</pre>
<p>
<div class="line874">The signed GPG key for identification of the repository is:</div>
<p>
<div class="line867"></div>
<pre>wget -q http://repository.cairo-dock.org/ubuntu/cairo-dock.gpg -O- | sudo apt-key add -</pre>
<p>
<div class="line874">Then, to install Cairo-Dock, issue these two commands in the terminal:</div>
<p>
<div class="line867"></div>
<pre>sudo apt-get update<br /><br />as<br />sudo apt-get install cairo-dock cairo-dock-plug-ins</pre>
<p>
<div class="line874">Note: if you get the error "E: Couldn't find package cairo-dock-plug-ins" try the code below as it seems there has been a name change and the package is now called cairo-dock-plugins in intrepid.</div>
<p>
<div class="line867"></div>
<pre>sudo apt-get install cairo-dock-plugins</pre>
<p>There are no repositories available for releases older than Ubuntu 7.10 (Gutsy Gibbon). So, if you want Cairo-Dock for an older release, you must compile it or download the package.</p></blockquote>
<div class="separator" style="clear:both;text-align:-webkit-auto;"></div>
<p><strong><br />Compiz</strong><br />
<blockquote>
<h3>  Compiz Fusion</h3>
<p>Compiz Fusion is available as a separate Windows Manager, to allow advanced desktop effects such as the rotating cube desktop. Many Ubuntu users choose to run Compiz, which is quite fast in Ubuntu. Install:
<pre>sudo apt-get install compiz compizconfig-settings-manager compiz-fusion-plugins-main compiz-fusion-plugins-extra emerald librsvg2-common</pre>
<p>To change to Compiz as the Window Manager:</p>
<p>Note: You must logout and log back in for the change to take effect.
<ul />
<li>Select Compiz Configuration:</li>
<p>
<dl>
<dd>System -&gt; Preferences -&gt; CompizConfig Settings Manager </dd>
</dl>
<p>
<div class="editsection" style="float:right;margin-left:5px;">[<a href="http://ubuntuguide.org/index.php?title=Ubuntu:Intrepid&amp;action=edit&amp;section=46" title="Ubuntu:Intrepid">edit</a>]</div>
<p><a href="http://draft.blogger.com/blogger.g?blogID=9218207841285502012" name="Fusion_Icon"></a><br />
<h4>  Fusion Icon</h4>
<p>Fusion Icon is a tray icon that allows you to easily switch between window managers, window decorators, and gives you quick access to the Settings Manager. This allows quick toggling of 3-D desktop effects (that may not be compatible with some applications).
<pre>sudo apt-get install fusion-icon</pre>
<p>Applications -&gt; System Tools -&gt; Compiz Fusion Icon</p>
<p>You can then easily access CompizConfig Settings Manager from the icon.
<div class="editsection" style="float:right;margin-left:5px;">[<a href="http://ubuntuguide.org/index.php?title=Ubuntu:Intrepid&amp;action=edit&amp;section=47" title="Ubuntu:Intrepid">edit</a>]</div>
<p><a href="http://draft.blogger.com/blogger.g?blogID=9218207841285502012" name="Rotate_the_Compiz_Cube"></a><br />
<h4>  Rotate the Compiz Cube</h4>
<p>Set the CompizConfig Settings Manager to enable the "Desktop Cube" and "Rotate Cube" and "Viewport Switcher" options. Click on the icon for each to customize settings. For example, to change the appearance of the cube, click on the Desktop Cube icon to access its settings. You can set the hotkey buttons for rotating the cube in the "Viewport Switcher" settings. Otherwise, hold down the Ctrl+Alt+Left mouse button and drag the mouse (or touchpad) the direction you want to rotate the cube.</p>
<p>Remember, the cube rotates between desktops. It's not a cube unless you have at least 4 desktops running. You will not get a cube if you are only using 2 desktops (you will get a "plate"). You can still rotate the sides of the plate, of course, but it will not be a cube. (Recent users from the Windows OS may have no experience with the concept of simultaneous desktops, but they are nice once you learn how to use them).</p>
<p>When running Compiz fusion as the Windows Manager, you must change the default number of desktops from within CompizConfig Settings Manger. To enable 4 desktops:</p>
<dl>
<dd>CompizConfig Settings Manager -&gt; General -&gt; General Options -&gt; Desktop Size -&gt; Horizontal Virtual Size -&gt; 4 </dd>
</dl>
<p>When you start an application, you can assign it to any one of the 4 desktops by right-clicking the upper left corner of the application window and choosing the "To Desktop..." option. Rotating the cube shows the different desktops. You can also go to a desktop using the taskbar icon which shows the 4 desktops.
<div class="editsection" style="float:right;margin-left:5px;">[<a href="http://ubuntuguide.org/index.php?title=Ubuntu:Intrepid&amp;action=edit&amp;section=48" title="Ubuntu:Intrepid">edit</a>]</div>
<p><a href="http://draft.blogger.com/blogger.g?blogID=9218207841285502012" name="Emerald"></a><br />
<h3>  Emerald</h3>
<p>Emerald is the theme engine for Compiz Fusion. Multiple themes are available. (These themes originated from the Beryl project before it merged with Compiz to form Compiz Fusion.) The Emerald Theme Manager for Compiz Fusion can be installed:
<pre>sudo apt-get install emerald</pre>
<p></p></blockquote>
<p>Using a the tutorial right <a href="http://ubuntuforums.org/showthread.php?t=796572">here</a> i made my desktop look a little bit decent.</p>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2009/03/ac8db-screenshot-d1.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="400" src="/images/wp/ac8db-screenshot-d1.png?w=300" width="640" /></a></div>
<p>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2009/03/a8053-screenshot-d2.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="400" src="/images/wp/a8053-screenshot-d2.png?w=300" width="640" /></a></div>
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2009/03/d76f5-screenshot-d3.png" style="margin-left:1em;margin-right:1em;"><img border="0" height="400" src="/images/wp/d76f5-screenshot-d3.png?w=300" width="640" /></a></div>
<p>you can get really fancy when it comes to desktops, there is a lot you can do, from Conky, to screenlets, its really up to you to add whatever inspires you.</p>
