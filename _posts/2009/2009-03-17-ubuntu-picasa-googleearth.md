---
layout: post
title: "Ubuntu: Picasa, GoogleEarth"
date: 2009-03-17 17:08:00.000000000 -04:00
categories: [Multimedia, Ubuntu]
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '2529098750302628734'
  _oembed_acadb69db0645221ea2bb630b32f0b3a: "{{unknown}}"


excerpt_separator: <!--more-->

---
<h3>Picasa:</h3>
<p>Picasa is a picture manager software, that I love. Every time I am setting up an ubuntu machine I always add picasa. Good thing about picasa install, you can either add the repository for google (deb http://dl.google.com/linux/deb/ stable non-free ) and install it using the synaptic manager,</p>
<p>or you could install it, using its windows like install called .deb (deb, for Debian/Ubuntu i386:<br /><a href="http://dl.google.com/linux/deb/pool/non-free/p/picasa/picasa_3.0-current_i386.deb">http://dl.google.com/linux/deb/pool/non-free/p/picasa/picasa_3.0-current_i386.deb</a> [3/17/09])</p>
<div class="separator" style="clear:both;text-align:center;"><a href="#" style="margin-left:1em;margin-right:1em;"><img border="0" height="372" src="/assets/images/wp/ea845-picasa1.png?w=300" width="640" /></a></div>
<p>After a while, I noticed, picasa software install on ubuntu from the repository is very similar to the wine(program that allows you to install windows application in Ubuntu) installation. To get the latest version from windows, here are easy steps you can take.</p>
<p><strong>Install Latest Picasa  in ubuntu</strong></p>
<p>First you need to make sure You have Picasa already installed from the google repository, as well as WINE.</p>
<p>Add the Google testing repository to /etc/apt/sources.list file<br />
<blockquote>sudo gedit /etc/apt/sources.list</p></blockquote>
<p>Add the following line<br />
<blockquote>deb http://dl.google.com/linux/deb/ testing non-free</p></blockquote>
<p>Save and exit</p>
<p>Update the source list using the following command<br />
<blockquote>sudo apt-get update</p></blockquote>
<p>Install picasa using the following command<br />
<blockquote>sudo apt-get install picasa</p></blockquote>
<p>First you need to install wine using the following command<br />
<blockquote>sudo apt-get install wine</p></blockquote>
<p>Now you need to download the latest windows version from <a href="http://picasa.google.com/" target="_blank">here</a></p>
<p>Once downloaded .exe file install this by double clicking on it.</p>
<p>Now you need to copy installed picasa  from<br />
<blockquote>/home/YOUR_USER_NAME/.wine/drive_c/Program Files/Google/Picasa3</p></blockquote>
<p>to<br />
<blockquote>/opt/google/picasa/3.0/wine/drive_c/Program Files/Google/Picasa3</p></blockquote>
<p>Use the following command to copy or use nautilus<br />
<blockquote>su cp -r /home/YOUR_USER_NAME/.wine/drive_c/Program Files/Google/Picasa3<br />/opt/google/picasa/3.0/wine/drive_c/Program Files/Google/Picasa3</p></blockquote>
<p>Once done, You can open Picasa 3.5 from your Applications &gt; <a href="http://draft.blogger.com/blogger.g?blogID=9218207841285502012#" target="_blank">Graphics</a> &gt; Picasa</p>
<p><strong><span style="color:olive;">*(06/21/2010) These instructions worked for picasa3.4, 3.5, and 3.6</span></strong><br />
<h3>GoogleEarth 5.0:</h3>
<p>Don't know if any of you have any interests in googleearth at all, I honestly think its pretty cool.</p>
<p>1- Download .bin file from the official website <a href="http://earth.google.com/intl/en/download-earth.html">http://earth.google.com/intl/en/download-earth.html</a> [3/17/09]</p>
<p>2- How to install the .bin file<br />cd /path of file/<br />sudo chmod +x file.bin<br />./file.bin</p>
<p>3- DO NOT RUN GOOGLE EARTH AFTER INSTALL, you most likely going to get error</p>
<p>./googleearth-bin: relocation error: /usr/lib/i686/cmov/libssl.so.0.9.8: symbol BIO_test_flags, version OPENSSL_0.9.8 not defined in file libcrypto.so.0.9.8 with link time reference</p>
<p>4. cd /opt/google-earth<br />sudo  mv libcrypto.so.0.9.8 libcrypto.so.0.9.8.old</p>
<p>for more details check this google earth <a href="http://www.google.com/support/forum/p/earth/thread?tid=7b1b524777b9b982&amp;hl=en">community thread</a>
<div class="separator" style="clear:both;text-align:center;"><a href="#" style="margin-left:1em;margin-right:1em;"><img border="0" height="400" src="/assets/images/wp/d0501-googleearth1.png?w=300" width="640" /></a></div>
<p><span style="color:olive;"><strong>*Update (5/18/2009):  Here is a recent issue that came up with Google earth the last time i tried to install it.</strong></span></p>
<p><strong><span style="color:red;">Could not create directory: /root/.googleearth/Cache </span></strong></p>
<p><span style="text-decoration:underline;"><strong><span style="color:red;">FIX:</span> </strong></span>edit your .config/Google/GoogleEarthPlus.conf replacing /root with your home directory for the following two lines:</p>
<p>KMLPath=/root/.googleearth<br />CachePath=/root/.googleearth/Cache</p>
<p><strong><span style="color:olive;">*Update (6/21/2010): at this point google earth installs smoothly without issue</span></strong><br />
<h3>Picasa-image viewer:</h3>
<p>I was jealous of my windows friend that could view her pics using the Picasa-image viewer, how is how to set it up.</p>
<p>Just Download this Deb file, I found it somewhere on the net, it works fine, couldn't find who created it or how the person did it. <a href="http://rfobic.googlepages.com/PicasaPhotoViewer-1.0.2.deb"></a></p>
<p><a href="http://rfobic.googlepages.com/PicasaPhotoViewer-1.0.2.deb">http://www.caiacoa.de/Transfer/PicasaPhotoViewer-1.0.3.deb </a>(Requires Picasa 3+) [11/07/09]</p>
<p>To make it the default viewer, If you have <a href="http://ubuntu-tweak.com/">Ubuntu Tweaks </a>(Go to System&gt;FileTypeManagement)  and you can set picasa image viewer for all the images applications, or<br />To make PicasaPhotoViewer the default program for all JPEG files for a particular user, do the following:</p>
<p>1. right click on a JPEG image, then go to properties. in the properties window go to the "OPEN WITH" tab... and select "PicasaPhotoViewer"... if u dont find the program there.. then press the "+ADD" button, then go to 'use a personalizated command' and type "PicasaPhotoViewer".</p>
<p>This creates a PicasaPhotoViewer desktop configuration file in ~/.local/share/applications/</p>
<p>2. edit ~/.local/share/applications/mimeapps.list and change the line beginning with image/jpeg, so that PicasaPhotoViewer is the first application in the list, eg:</p>
<p>image/jpeg=userapp-PicasaPhotoViewer-BL3WOU.desktop;eog.desktop;firefox.desktop;gimp.desktop;thunderbird.desktop;</p>
<p>To make Picasa Photo Viewer the default for ALL users do the following</p>
<p>1. copy the PicasaPhotoViewer desktop configuration file from ~/.local/share/applications/ to /usr/share/applications/PicasaPhotoViewer.desktop</p>
<p>2. add the following lines</p>
<p>MimeType=image/x-bmp;image/bmp;image/gif;image/x-psd;image/x-tga;image/tiff;image/jpeg;image/jpg;image/png;<br />Icon=PicasaPhotoViewer</p>
<p>3. to tell GNOME to use this desktop configuration file for JPG mime types type the following at the terminal:</p>
<p>xdg-mime default PicasaPhotoViewer.desktop image/jpeg<br />xdg-mime default PicasaPhotoViewer.desktop image/jpg</p>
<p><span style="color:olive;"><strong>*Update (6/21/2010): at this point picasa image viewer wasn't helpful anymore, because </strong></span><a href="http://gloobus.net/"><span style="color:olive;"><strong>Gloobus</strong></span></a><span style="color:olive;"><strong> does a better job at it.</strong></span></p>
