---
layout: post
title: "Ubuntu: Installing Eclipse"
date: 2009-03-17 17:24 -0400
categories: [IDE, Productivity]
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '6562761364746504982'

excerpt_separator: <!--more-->

---
<div class="separator" style="clear:both;text-align:center;"><a href="#" style="clear:left;float:left;margin-bottom:1em;margin-right:1em;"><img border="0" src="/assets/images/wp/5ca65-easyeclipse_icon.png" /></a></div>
<p>Eclipse is a software we use at school for java programing, for me, its a priority to have eclipse functional.</p>
<p><a href="http://ubuntuforums.org/showthread.php?t=941461">here is a tutorial that i got from the Ubuntu community.  I copied the text word for word,because  sometimes some of these threads get deleted, just wanted to make sure, I still have a reference to it.</a><br />
<blockquote>
<div class="smallfont"><strong><span style="text-decoration:underline;"><span style="color:red;">The original Tutorial was meant to work for eclipse 3.4 on Hardy heron, but is also valid for Intrepid, Jaunty, Karmic, and all the versions of eclipse 3.4+</span></span></strong></div>
<p>
<div class="smallfont"></div>
<p>
<div class="smallfont"><strong>[Tutorial]: Installing Eclipse 3.4 in Hardy Heron (8.04)</strong></div>
<p>
<hr size="1" />
<div class="vbclean_msgtext" id="post_message_5927944">The following notes may be helpful in doing a basic installation of Eclipse. Please note that this does not include the 'tuning' (i.e. setting parameters) that is required to get the installation working correctly.Eclipse</p>
<p>This is a general purpose IDE used for development. The current version is 3.4 (Ganymede). This must be installed directly from the website (<a href="http://www.eclipse.org/" target="_blank">http://www.eclipse.org</a>), since the version of eclipse in the repositories is not current.</p>
<p>The original source for these instructions is: <a href="http://flurdy.com/docs/eclipse/install.html" target="_blank">http://flurdy.com/docs/eclipse/install.html</a>. The original instructions were applicable to Eclipse Europa and have been updated here to include Ganymede.</p>
<p>Overview<br />As the result of these installation instructions<br />1. the main eclipse application will be installed in /opt/eclipse.<br />2. there will be a command shell located in /usr/local/bin.<br />3. there will be an eclipse folder in /usr/local/share.<br />4. there will be a desktop launcher (eclipse.desktop) in /usr/share/applications.</p>
<p>Prior to starting this process,<br />1. sun java jdk must be installed. This may be installed from the repository through synaptic or using a terminal. In the case of terminal, type:
<div style="margin:5px 20px 20px;">
<div class="smallfont" style="margin-bottom:2px;">Code:</div>
<p>
<pre class="alt2" style="border:1px inset;height:34px;margin:0;overflow:auto;padding:6px;text-align:left;width:640px;">sudo apt-get install sun-java6-jdk</pre>
<p></div>
<p></div>
<p>
<div class="vbclean_msgtext" id="post_message_5927944">.<br />2. a suitable icon must be found and downloaded. When completed, the icon will be located in /opt/eclipse. A suitable icon is located at <a href="http://blog.benjamin-cabe.com/wp-content/uploads/2008/05/ganymede.png" target="_blank">http://blog.benjamin-cabe.com/wp-con...5/ganymede.png</a> <span style="text-decoration:underline;"><strong><span style="color:red;">(this icon is for 3.4, google it if you need a better icon)</span></strong></span> and may be initially downloaded to the Desktop or to any other location where it can be easily located.Installation Instructions<br />1. Verify that any previous installation has been completely removed. In particular, the following needs to be verified:<br />a. There is no eclipse folder under /opt. If there is, it must be deleted. Sudo access will be required to delete the folder.<br />b. There is no eclipse folder under /usr/local/share. If there is, it must be deleted. Sudo access will be required to delete the folder.<br />b. There is no entry for eclipse in either /usr/bin or /usr/local/bin. If there is, then the entry must be deleted.<br />c. There is no entry for eclipse.desktop in /usr/share/applications. If there is, then the entry must be deleted.<br />b. There is no configuration files for eclipse in the users' home folders. These are hidden directories. If there are any, these must be deleted.</p>
<p>2. Obtain the appropriate file from <a href="http://www.eclipse.org/downloads/packages/" target="_blank">http://www.eclipse.org/downloads/packages/</a>. Only one of the packages is required. The file should be saved to the Desktop.</p>
<p>3. When the download has been completed, open a Terminal and execute the following commands:<br />cd ~/Desktop<br />tar xzf eclipse-SDK-3.4-linux-gtk.tar.gz (note that the filename may differ, depending on what was downloaded in step 2)<br />sudo mv eclipse /opt/eclipse<br />sudo mv ganymede-logo.png /opt/eclipse (this will move the icon. The filename and location for the logo may differ - depending where it was saved)<br />cd /opt<br />sudo chown -R root:root eclipse<br />sudo chmod -R +r eclipse<br />cd /opt/eclipse<br />sudo chmod +x eclipse</p>
<p>4. Create an executable shell for eclipse. This is done through Terminal by executing the following commands:<br />sudo touch /usr/local/bin/eclipse (this assumes that /usr/local/bin is in the path)<br />sudo chmod 755 /usr/local/bin/eclipse<br />sudo nano /usr/local/bin/eclipse (this will open the nano editor)</p>
<p>5. When the eclipse shell file is open (in nano), the following contents need to be inserted and the file saved:<br />#!/bin/sh<br />export ECLIPSE_HOME="/opt/eclipse"<br />$ECLIPSE_HOME/eclipse $*</p>
<p>6. Create a GNOME menu item. This is done through Terminal by executing the following command:<br />sudo nano /usr/share/applications/eclipse.desktop</p>
<p>7. When the GNOME menu item is open (in nano), the following contents need to be inserted and the file saved:<br />[Desktop Entry]<br />Encoding=UTF-8<br />Name=Eclipse<br />Comment=Eclipse Ganymede IDE<br />Exec=eclipse<br />Icon=/opt/eclipse/ganymede-logo.png<br />Terminal=false<br />Type=Application<br />Categories=GNOME;Application;Development<br />StartupNotify=True</p>
<p>8. Initialise eclipse by running the following command in Terminal: /opt/eclipse/eclipse --clean.</p>
<p>From this point forward, eclipse may be run from the Application menu.</p>
<p>Please let me know how these work for you, and if you need any additional help.</p>
</div>
<p>
<div class="vbclean_msgtext">ALL CREDITS GO TO OWNER OF THE ORIGINAL POST</div>
<p>
<div class="vbclean_msgtext">
<div id="postmenu_5927944"><a class="bigusername" href="http://ubuntuforums.org/member.php?u=574272">fballem</a> </div>
<p></div>
</blockquote>
