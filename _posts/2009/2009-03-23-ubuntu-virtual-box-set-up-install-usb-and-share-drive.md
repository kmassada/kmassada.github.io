---
layout: post
title: "Ubuntu: Virtual Box Set-up, Install, USB and Share Drive"
date: 2009-03-23 17:03:00.000000000 -04:00
categories: [Tools and Utilities, virtualization]
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '1172991600526475794'


excerpt_separator: <!--more-->

---
<p>Hello,</p>
<p>I talked in one of the earlier posts about trying ubuntu on a virtual machine to make sure that it could run in your machine. I woke up one day and I deleted my windows, But I needed to able to run certain software.</p>
<p><strong>WINE,</strong> is a software that allows you to run windows applications, but not a the level I needed it to be done.</p>
<p>There are 2 main virtual machine softwares out there. <strong>Vmware and Virtual Box</strong>, people claim on most blogs that Vmware is the best. I decided to get virtual box because it didn't make me go through a very tideous registration process.</p>
<p><strong>How to get Virtual Box?</strong> you can get it from its official <a href="http://www.virtualbox.org/wiki/Downloads">Download website</a> You should download it according to the System you are presently running, so you select UBUNTU if your system is ubuntu.</p>
<p><strong>Follow the following instructions for the install, </strong><strong><span style="color:olive;">the versions may differ, go to <a href="http://www.virtualbox.org/wiki/Linux_Downloads">this website </a> for current formation</span></strong><br />
<blockquote><span style="color:red;">* Debian-based Linux distributions: Add one of the following lines according to your distribution to your /etc/apt/sources.list:</span></p>
<p><span style="color:#3d85c6;">deb http://download.virtualbox.org/virtualbox/debian intrepid non-free</span></p>
<p><span style="color:red;">The Sun public key for apt-secure can be downloaded here. You can add this key with</span></p>
<p><span style="color:#3d85c6;">sudo apt-key add sun_vbox.asc</span></p>
<p><span style="color:red;">or combine downloading and registering:</span></p>
<p><span style="color:#3d85c6;">wget -q http://download.virtualbox.org/virtualbox/debian/sun_vbox.asc -O- | sudo apt-key add -</span></p>
<p><span style="color:red;">The key fingerprint is</span></p>
<p><span style="color:#3d85c6;">AF45 1228 01DA D613 29EF  9570 DCF9 F87B 6DFB CBAE<br />Sun Microsystems, Inc. (xVM VirtualBox archive signing key)</span></p>
<p><span style="color:red;">To install VirtualBox, do</span></p>
<p><span style="color:#3d85c6;">apt-get install virtualbox-2.1</span></p>
<p><span style="color:red;">Replace virtualbox-2.1 by virtualbox to install VirtualBox 1.6.6, or replace it by virtualbox-2.0 to install VirtualBox 2.0.6.</span></p>
<p><span style="color:red;">Note: Ubuntu users might want to install the dkms package (not available on Debian) to ensure that the VirtualBox host kernel modules (vboxdrv and vboxnetflt) are properly updated if the linux kernel version changes during the next apt-get upgrade.</span></p></blockquote>
<p>So far never heard of someone having troubles with the installation. So you should technically be fine after install.</p>
<p>Once the install is completed, you can go ahead and create a virtual machine, the procedures for this are pretty much self explanatory. It will ask you to assign, some ram space, and some local hard drive space, please be reasonable with those. You need to have the cd or the ISO for the OS you trying to Install. for more info<a href="https://help.ubuntu.com/community/VirtualBox"> (this GUIDE)</a> is helpful.</p>
<p><strong><span style="color:olive;">This post was written for Jaunty, and instructions worked for Karmic,  Here is the<a href="https://help.ubuntu.com/community/VirtualBox"> Ubuntu Community Virtual Box </a> post that is up to date on how to add the USB, and Guest additions, or other things that i've mentioned in this post. </span></strong></p>
<p><strong>INSTALL THE GUEST ADDITIONS</strong>: haven't had the chance of exploring the full power of this option, but it comes in pretty handy. To install it, when you start up your virtual machine, got to <strong>Devices</strong> then <strong>Install the Guest Additions</strong>.</p>
<p><strong>ENABLING USB</strong><br />Add yourself to the VBOXUSERS<br />
<blockquote>1- Go to Menu &gt; System &gt; Administration &gt; Users and Groups<br />2- Select your account and click on Unlock<br />3- Then Click on Manage Groups then go to Vboxusers then click on properties<br />4- check your user name and the root profiles</p></blockquote>
<p>THEN<br /><strong>Edit the permissions manually <span style="color:red;">(this works for Jaunty and Intrepid)</span></strong><br />
<blockquote><span style="color:red;">gksudo gedit /etc/init.d/mountdevsubfs.sh</span></p></blockquote>
<p>inside that file, right before the do Start() { } ends, paste in the following<br />
<blockquote><span style="color:red;"># Magic to make /proc/bus/usb work</span></p>
<p><span style="color:red;">mkdir -p /dev/bus/usb/.usbfs<br />domount usbfs "" /dev/bus/usb/.usbfs usbfs -obusmode=0700,devmode=0600,listmode=0644<br />ln -s .usbfs/devices /dev/bus/usb/devices<br />mount --rbind /dev/bus/usb /proc/bus/usb</span></p></blockquote>
<p><strong>NEW INSTRUCTIONS FOR KARMIC</strong><br />
<blockquote>1.Open up VirtualBox,select the virtual machine and click on <strong> Settings</strong>.Then select USB in left and check the two checkboxes.</p>
<p>2.Open up terminal(Applications-&gt;Accessories-&gt;Terminal).Create usb group and add current user to the group:
<div>
<div>
<pre>sudo groupadd usbfs<br />sudo adduser your_username_here usbfs</pre>
<p></div>
</div>
<p>3.Use this command,and you will get group id:
<div>
<div>
<pre>cat /etc/group | grep usbfs</pre>
<p></div>
</div>
<p>Example of output:
<div>
<div>
<pre>usbfs:x:1001:wraith</pre>
<p></div>
</div>
<p>Here,<strong>1001</strong> is the group id.<br />4.Edit /etc/fstab by this command:
<div>
<div>
<pre>sudo gedit /etc/fstab</pre>
<p></div>
</div>
<p>Add this line in the bottom.
<div>
<div>
<pre>none /proc/bus/usb usbfs devgid=1001,devmode=664 0 0</pre>
<p></div>
</div>
<p>Here 1001 is the group id in step 3. </p></blockquote>
<blockquote><p>5.Run following command:
<div>
<div>
<pre>sudo chmod 777 /proc/bus/usb</pre>
<p></div>
</div>
<p>Restart your computer.</p></blockquote>
<p><strong>SHARING LOCAL FILES</strong></p>
<p><strong>FIRST</strong><br />Go to the Virtual Box, click on the virtual machine, then click on Settings, then on shared folder and Add the location of the file you trying to share.</p>
<p><strong>OR YOU COULD DO IT MANUALLY BY </strong><br />
<blockquote><span style="color:red;">mkdir ~/VirtualBoxShare<br />VBoxManage sharedfolder add "XP" -name "share" -hostpath /home/your/shared/folder/VirtualBoxShare/</span></p>
<p>Where "XP" is the name of the virtual machine in VirtualBox, and "share" is the name of the share as the guest machine will see it. The hostpath must be a fully-qualified path.</p></blockquote>
<p><strong>THEN</strong><br />
<blockquote>On the Windows client, run</p>
<p><span style="color:red;">net use x: \\vboxsvr\share</span><br />If the client is Linux, run<br /><span style="color:red;">mount -t vboxfs share mountpoint</span><br />For the above command if you get error as<br /><span style="color:red;">mount: unknown filesystem type 'vboxfs'</span><br />Then just change the vboxfs to vboxsf means the command will be<br /><span style="color:red;">mount -t vboxsf share mountpoint</span></p></blockquote>
<p><strong>SEAMLESS MODE</strong></p>
<p>There is something call seemless mode that you can enable when your Guest additions are well configured. It integrate the virtual with the host. Look at the screen shot bellow</p>
<div class="separator" style="clear:both;text-align:center;"><a href="#" style="margin-left:1em;margin-right:1em;"><img border="0" height="400" src="/assets/images/wp/18a35-seamless-mode.png?w=300" width="640" /></a></div>
