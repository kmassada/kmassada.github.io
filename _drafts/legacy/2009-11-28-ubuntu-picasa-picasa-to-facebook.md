---
layout:
title: "Ubuntu: Picasa, Picasa to Facebook"
date: 2009-11-28 22:16 -0500
categories:
- Multimedia
- Ubuntu
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '6478446201364959461'
author:
  login: kmassada
  email: admin@kmassada.com
  display_name: kmassada
  first_name: 'Kenneth'
  last_name: 'Massada'
excerpt: !ruby/object:Hpricot::Doc

---
<div class="separator" style="clear:both;text-align:center;"><a href="http://techronilces.files.wordpress.com/2009/11/42136-facebook-picasa.gif" style="clear:left;float:left;margin-bottom:1em;margin-right:1em;"><img border="0" height="138" src="/images/wp/42136-facebook-picasa.gif?w=300" width="200" /></a></div>
<p>Always enjoyed using Picasa, but only problem was never able to upload facebook albums directly from Picasa, here is a little tutorial  that helped me upload things directly to Facebook from Picasa.</p>
<p>Alright, preknowldge ~ = /home/yourusername/<br />Here is how to do it<br />Open a terminal and..</p>
<p><strong> 1-Install IE</strong><br />we first install IE4Linux from <a href="http://www.tatanka.com.br/ies4linux/page/Installation">their website.</a><br />
<blockquote><strong>wget </strong><a href="http://www.tatanka.com.br/ies4linux/downloads/ies4linux-latest.tar.gz"><strong>http://www.tatanka.com.br/ies4linux/downloads/ies4linux-latest.tar.gz</strong></a><strong><br />tar zxvf ies4linux-latest.tar.gz<br />cd ies4linux-*<br />./ies4linux</strong></p></blockquote>
<p>you get an error<br /><strong> run ./ies4linux again</strong><br />you get another error<br /><strong> run ./ies4linux again</strong></p>
<p>It should now say that you've installed IE4 and that it's exacutable is in ~/bin/ie6<br />Notice that there is a new wine root installed in ~/.ies4linux/ie6<br />AHA<br />
<blockquote><strong>NOW download the WINDOWS VERSION OF PICASA!!! to your ~/.ies4linux/ie6/drive_c folder</strong></p></blockquote>
<p>as of now that is: <a href="http://dl.google.com/picasa/picasa35-setup.exe">http://dl.google.com/picasa/picasa35-setup.exe</a><br />google picasa to download the latest Picasa</p>
<p>Alright, now you have to start the setup within the ~/.ies4linux/ie6 root environment. How?</p>
<p>Open a terminal and copy and paste (shift+insert) the following command and edit so it fits your system<br />
<blockquote><strong>env WINEPREFIX="/home/user/.ies4linux/ie6" wine "C:\picasa35-setup.exe"</strong></p></blockquote>
<p>DONT FORGET TO CHANGE user to YOUR username</p>
<p>Now run through the setup then check<br />
<blockquote><strong> ~/.ies4linux/ie6/drive_c/Program files/google/Picasa3/</strong></p></blockquote>
<p><strong></strong>is it there? good then you have done it right otherwise start over..</p>
<p>now go here<br />
<blockquote><a href="http://apps.facebook.com/picasauploader/faq.php?#installation">http://apps.facebook.com/picasauploa...?#installation</a></p></blockquote>
<p>or use this link<br />
<blockquote><a href="http://webkinesis.com/fbpicasa/packages/v2/facebook_v2.pbz">http://webkinesis.com/fbpicasa/packa...acebook_v2.pbz</a></p></blockquote>
<p>to download the facebook plugin download it to<br />
<blockquote><strong>~/.ies4linux/ie6/drive_c/Program Files/Google/Picasa3/buttons</strong></p></blockquote>
<p>clean up your mess that you extracted and downloaded before<br />
<blockquote><strong>rm -rf ies4linux*</strong></p></blockquote>
<p>Then start Picasa!!!<br />
<blockquote><strong>env WINEPREFIX="/home/user/.ies4linux/ie6" wine "C:\Program files\Google\Picasa3\Picasa3.exe"</strong></p></blockquote>
<p>DONT forget to change user to YOUR username</p>
<p>Now run Picasa you should see the facebook icon in picasa!!</p>
<p>Mark and upload your pictures..<br />Picasa will hang half the times but it will always upload your pictures to facebook!!</p>
<p>to close the hanged picasa use<br />
<blockquote><strong>pkill -9 wineserver</strong></p></blockquote>
<p>source: <a href="http://ubuntuforums.org/showpost.php?p=7911642&amp;postcount=10">nidelius</a></p>
<p><span style="color:red;"><strong>Lucid and Maverick releases still did not solve issue, users are leaning to native apps, <a href="http://www.techradar.com/news/software/applications/8-of-the-best-photo-managers-for-linux-692441?src=rss&amp;attr=all">here's a link </a> that might help in deciding which photo manager to go for. </strong></span></p>
