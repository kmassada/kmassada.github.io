---
layout: post
title: VNC (x11vnc) over SSH Tunnel on Ubuntu 12.10 and nexus 7 as a client
date: 2012-12-23 22:40:00.000000000 -05:00
categories: [Network, Staff Picks]
tags: []
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '8572139016306905025'


excerpt_separator: <!--more-->

---
<p>Alright, so after I <a href="http://www.techronicles.net/2012/12/openvpn-server-on-ubuntu-1210-with.html" target="_blank">connect to my VPN</a> at home, I can do a lot of different things, <a href="http://www.techronicles.net/2012/12/tighten-security-around-your-ssh-session.html" target="_blank">SSH is one of them</a>. I also needed a solution to control my screen from anywhere. VNC is my answer. Ubuntu has a lot of <a href="https://help.ubuntu.com/community/VNC/Servers" target="_blank">vnc servers</a>, I chose x11vnc, because it works well with lightdm, my default X manager. And I also needed a vnc server that will allow me to connect even before logging in.</p>
<p>As you can see in the two post I've linked, Security is key for me. In the past, i've used <a href="https://docs.google.com/document/d/1I2UibaSXvYmdvXMYSbYmJ2CQ6zETxqOwHMXq9sWrtrk/edit" target="_blank">SSL certificates, and x11VNC</a> this solution will make you create a CA that will sign a server certificate, and also client certificates, that you can then distribute to different clients. This solution uses 3 passwords and 2 certificates. I've done that because, before even VPN, VNC was the first and only point of entry to my network.</p>
<p>And also x11VNC is very powerful, try to<a href="http://www.karlrunge.com/x11vnc/x11vnc_opts.html" target="_blank"> judge for yourself.</a></p>
<p>The previous solution was great, worked perfect. however, the bVNC supports SSL VNC, but doesn't import the certificates like I needed it to. I also decided to do it over SSH because, normal VNC communications aren't encrypted.</p>
<p><a name="more"></a></p>
<p><b>On Server</b></p>
<p>First of all, I’ve installed x11vnc:<br />

{% highlight bash %}
 sudo apt-get install x11vnc
{% endhighlight %}

</p>
<p>Set a password:<br />

{% highlight bash %}
 sudo x11vnc -storepasswd /etc/x11vnc/pass
{% endhighlight %}

</p>
<p>Its an<br />Then, I’ve created

{% highlight bash %}
  /etc/init/x11vnc.conf  
{% endhighlight %}

file:</p>
<p>

{% highlight bash %}
 start on login-session-start
 {% endhighlight %}
{% highlight bash %}
x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :0 -rfbauth /etc/x11vnc/pass -auth /var/run/lightdm/root/:0 -forever -bg -o /var/log/x11vnc.log -rfbport 5917
{% endhighlight %}

</p>
<p>After restart, x11vnc should listen on vnc standard port – 5917.<br />This script is based on upstart event. 

{% highlight bash %}
 /var/run/lightdm/root/:0
{% endhighlight %}

is because I'm requesting root access to the X manager, if you are using gdm as your default X Manager, try

{% highlight bash %}
  -auth /var/lib/gdm/:0.Xauth -display :0
{% endhighlight %}

 . Or get on board

{% highlight bash %}
 sudo dpkg-reconfigure lightdm  
{% endhighlight %}

and make lightdm your default. 

</p>
<p>at this point you can reboot server. or just run,<br />

{% highlight bash %}
 sudo x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :0 -rfbauth /etc/x11vnc/pass -auth /var/run/lightdm/root/:0 -forever -bg -o /var/log/x11vnc.log -rfbport 5917
{% endhighlight %}

</p>
<p><b>On nexus 7</b></p>
<p>install an app called <a href="https://play.google.com/store/apps/details?id=com.iiordanov.freebVNC" target="_blank">freeb VNC</a></p>
<p>click on icon to install app.</p>
<div class="separator" style="clear:both;text-align:left;"><a href="https://play.google.com/store/apps/details?id=com.iiordanov.freebVNC" style="margin-left:1em;margin-right:1em;" target="_blank"><img border="0" src="/images/wp/2daef-unnamed.png" /></a></div>
<p>In app fill in the form. lol.<br />Self Explanatory, ssh port is 5848, VNC port on server is 5917,</p>
<p><a href="#" style="clear:left;margin-bottom:1em;margin-right:1em;text-align:center;"><img border="0" height="640" src="/images/wp/ebb8e-2012-12-2316-34-19.png?w=187" width="400" /></a></p>
<p>click on use key, then manage key, set a password of course, make encryption  4096 bits, then enter a file name, and select export to file name.</p>
<div class="separator" style="clear:both;text-align:left;"><a href="#" style="clear:left;float:left;margin-bottom:1em;margin-right:1em;"><img border="0" height="640" src="/images/wp/3a115-2012-12-2311-17-03.png?w=187" width="400" /></a></div>
<div class="separator" style="clear:both;text-align:left;">That file contains the following format, ssh-rsa KEY pubkeygenerator@mobiledevice, </div>
<div class="" style="clear:both;text-align:center;"></div>
<div style="text-align:start;">find a way of appending that string to ~/.ssh/authorized_keys on your server. </div>
<div style="text-align:start;"></div>
<div style="text-align:start;">the way I do it, is I copy to clipboard, open ConnetBot, ssh into my server, </div>
<div style="text-align:start;">then type echo "press menu to PASTE KEY HERE" &gt;&gt; .ssh/authorized_keys</div>
<div style="text-align:start;"></div>
<div style="text-align:start;">another way is to email yourself the key, and append it in command line by doing </div>
<div style="text-align:start;">echo "PASTE KEY HERE" &gt;&gt; .ssh/authorized_keys</div>
<div style="text-align:start;"></div>
<div style="text-align:start;">then connect </div>
<div style="text-align:start;"></div>
<div style="text-align:start;"><a href="#" style="clear:left;margin-bottom:1em;margin-right:1em;text-align:center;"><img border="0" height="640" src="/images/wp/ebb8e-2012-12-2316-34-19.png?w=187" width="400" /></a></div>
<div style="text-align:start;"></div>
<div style="text-align:start;">I'm in, that's my login screen</p>
<div class="separator" style="clear:both;text-align:center;"><a href="#" style="clear:left;float:left;margin-bottom:1em;margin-right:1em;"><img border="0" height="640" src="/images/wp/25422-2012-12-2315-05-07.png?w=187" width="400" /></a></div>
<div>
<div class="separator" style="clear:both;text-align:center;"></div>
<p>couple of things to note,</p>
<p>1- the setup on an ubuntu client is simple, i'm however without one for the moment, few logistic problems. I'll add them when I fix my little issue.</p>
<p>-- the concept is simple though, you create the tunnel through ssh. run that process in background, then you use vnc viewer to connect to your localhost:port</p>
<p>2- also I didn't open any other ports on my server, that's because I don't need one. communication is sent through ssh port, tunneled to localhost:VNCPORT.</p></div>
</div>
