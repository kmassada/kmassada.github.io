---
layout:
title: "[Brainstorming] Streaming my music after vpn connect using ubuntu as a server and both nexus 7 and Ubuntu client."
date: 2013-01-27 16:40 -0500
categories: [Home, Media]
tags: blogger
status: publish
type: post
published: true
meta:
  blogger_blog: www.techronicles.net
  blogger_author: Kenneth Massada
  blogger_ff04fb872097e84c3f74ac8dafe273de_permalink: '8042791122711757412'


excerpt_separator: <!--more-->

---
I post when a setup is successful, but someone suggested, why don't I also blog my challenges, so here's one.<br>
<b>The problem:</b> once in my home environment I want to be able to stream my Music to all the nodes. I want to also be able to stream playlists to my endpoints. <i>Optionally I would love to make playlists remotely and stream. Do not care as much for other types of media.</i><br>
<b>Constraints:</b> i access my environment via vpn only. I refuse to open any other ports to the outside. I also refuse to use windows.

<img border="0" height="200" src="/assets/images/wp/154123-headphones-headphones.jpg" width="320" />

<a name="more"></a>
<b>Plausible Solutions:</b><br />

<b><i>- nfs:</i></b> my music is on an <a href="https://help.ubuntu.com/community/SettingUpNFSHowTo">nfs</a> drive, I can mount it on <a href="http://askubuntu.com/questions/28733/how-do-i-run-a-script-after-openvpn-has-connected-successfully">vpn connect</a> through a script, then use any clients to import the folder location.<br />
<i>problems:</i> messy solution, and very slow stream and doesn't include my playlists. Also depending on client they mess with my folder structure for music items.<br>

<b><i>- daap:</i></b> daap is a protocol linux endpoints leverage to stream a music library. The server on ubuntu is called <a href="http://isaraffee.wordpress.com/2012/03/05/setup-music-sharing-server-using-tangerine-in-ubuntu/">tangerine</a>.
Its not quite a stream, you add the server with port to your player and it will play your music and will protect it with a password.<br />
<i>problems:</i> this solution is actually the best. But clients can only be Linux. I've yet to find a working client for windows. Still wont pick up my playlists.<br>

<b><i>- dnla/upnp:</i></b> plug and play, there are various solutions on Linux, i chose <a href="https://help.ubuntu.com/community/MediaTomb">mediatomb</a>.
It requires several ports but its biggest pro is it will stream to your PlayStation and any imaginable client.<br />
<i>problems:</i> this is also messy. It will only stream to one interface or one IP scheme. So when I connect through vpn, I launch a script that edits its config and restart the server literally. Database will not reload gently if you don't.
But once I'm home I do the reverse so I can still stream to my usual endpoints and it doesn't stream my playlists either. <br>

<b>Concessions:</b> I think I won't be able to get playlists streamed due to my contraints, my server runs <a href="http://banshee.fm/">banshee media player</a>, because my music is strictly album based, its the best solution I've found for organizing music. And the
playlists are saved internally to a database,  so even if stream server supports playlists, wont be able to pick up banshee playlists unless I export them.
