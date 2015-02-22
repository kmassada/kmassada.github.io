---
layout: post
title: "Raspberry Pi2"
modified:
categories: raspberrypi2
excerpt:
tags: []
date: 2015-02-19T23:35:01-05:00
---

Raspberry pi needs no introduction, regardless of what side of the house you are
If you need a reason to buy one, just look at the specs, 
The new Raspberry pi 2 comes with the following specs

* A 900MHz quad-core ARM Cortex-A7 CPU
* 1GB RAM
* 4 USB ports
* 40 GPIO pins
* Full HDMI port
* Ethernet port
* Combined 3.5mm audio jack and composite video
* Camera interface (CSI)
* Display interface (DSI)
* Micro SD card slot
* VideoCore IV 3D graphics core

### Getting Started

Just to fire-up the raspberry pi, here's what you need to get started: 

1. Micro SD card, preferably class 10 and above. 
* You may also need an SD Card reader to load image to your sdcard
2. The raspberry comes with and HDMI port
* You may need an hdmi cable or converter if your screen does not support hdmi
3. You need a USB keyboard and a mouse 
4. The raspbery pi comes with an Ethernet port. 
* You may need an rj-45 cable/ standard ethernet cable
* You also may need to set it up, where you have access to an Ethernet jack
5. Case is not a must, but a nice have. 
* I will be moving the pi between home and work, so I found it fitting to have a case
6. You need a 5V micro USB power supply to power the Pi. Most micro-usbs are 5V, read labels.
7. Wi-Fi dongle. (when purchasing, make sure you look into drivers support first)
* One of my priorities with the pi is portability. and this offers just that.  
8. Read manual very carefully, especially power warnings


### Picking an image 

Raspberry comes with many images for noobs, I however chose a standard debian, image ([RASPBIAN](http://raspbian.org/)). Came second to the Fedora counter-part [PIDORA](http://pidora.ca/). 

I've not done due diligence to find more images, I'm more eager to just get going. 

### Honorable mention

Ubuntu announced a dev-core image called [Snappy](http://www.markshuttleworth.com/archives/1434), it is meant to be a be minimal server image with the same libraries as traditional ubuntu server. This is still in alpha phases. I tried being a maverick, I've had little success getting my wi-Fi dongle to work.  But like expected the internals are very similar with ubuntu. 

Snappy also includes an easy to configure Web Device Management framework (WEBDM) to manage "snaps" add-ons on your OS. Here's a [good guide](http://blog.sergiusens.org/posts/Snappy%20Things/) that better describes webdm

And here's [ubuntu's guide to snappy](https://developer.ubuntu.com/en/snappy/)

### Building the image

This the [official guide](http://www.raspberrypi.org/documentation/installation/installing-images/linux.md) for installing images on linux. 

Once sdcard is in it's adapter and loaded into your computer, you can run the following commands to see what's mounted.

{% highlight bash %}
df -h
{% endhighlight %}

My sdcard mount point is mmcblk0p1, unmount it first
{% highlight bash %}
umount /dev/mmcblk0p1
{% endhighlight %}

Once you have downloaded an image at [http://www.raspberrypi.org/downloads/](http://www.raspberrypi.org/downloads/) you can unzip the image using this command 
{% highlight bash %}
unzip 2015-02-16-wheezy-raspbian.zip
{% endhighlight %}

Now you are ready to build the image file `2015-02-16-wheezy-raspbian.img`
**be careful, this is a command that will overwrite a partition if you pick the wrong one, if in doubt refer to official documentation. also note 'mmcblk0' not 'mmcblk0p1,p2'**  
{% highlight bash %}
sudo dd bs=4M if=2015-02-16-wheezy-raspbian.img of=/dev/mmcblk0
{% endhighlight %}


sync, to reload cache, and remove sdcard
{% highlight bash %}
sync
{% endhighlight %}


### Starting the image [RASPBIAN]

Once sdcard inserted. power the Pi by inserting the power cable. 

RASPBIAN setup is self explanatory, it allows you to configure ahead of time, few variables, before the image fully boots. 
<figure>
<img src="/images/pi-raspi-config-main.png">
</figure>

I've ran through all of the options above. Especially `ssh` and setting the locales for the keyboard. this command is still available passed the initial config at `sudo raspi-config`

Remember to reboot after initial config. 
{% highlight bash %}
reboot now!
{% endhighlight %}

### Wifi Setup

I was really disappointed that the wifi-dongle was automatically detected, but not entirely surprised. 
my dongle runs on `RTl8192/8188CUS Chipset`

`lsub` showd the dongle

{% highlight bash %}
$ lsusb 
Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp. 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp. 
Bus 001 Device 004: ID 0bda:8176 Realtek Semiconductor Corp. RTL8188CUS 802.11n WLAN Adapter
{% endhighlight %}

`lsmod` shows the loaded module including the model for my dongle's chipset
{% highlight bash %}
$ lsmod
Module                  Size  Used by
snd_bcm2835            18850  0 
snd_pcm                75388  1 snd_bcm2835
snd_seq                53078  0 
snd_seq_device          5628  1 snd_seq
snd_timer              17784  2 snd_pcm,snd_seq
snd                    51667  5 snd_bcm2835,snd_timer,snd_pcm,snd_seq,snd_seq_device
8192cu                528429  0 
uio_pdrv_genirq         2958  0 
uio                     8119  1 uio_pdrv_genirq
{% endhighlight %}

more info about module
{% highlight bash %}
$ modinfo 8192cu
filename:       /lib/modules/3.18.7-v7+/kernel/drivers/net/wireless/rtl8192cu/8192cu.ko
version:        v4.0.2_9000.20130911
author:         Realtek Semiconductor Corp.
description:    Realtek Wireless Lan Driver
license:        GPL
{% endhighlight %}

I ran `sudo iwlist wlan0 scan` just to scan the wireless networks. 

{% highlight bash %}
$ sudo ifdown wlan0
Internet Systems Consortium DHCP Client 4.2.2
Copyright 2004-2011 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/
Listening on LPF/wlan0/$MACADDRESS
Sending on   LPF/wlan0/$MACADDRESS
Sending on   Socket/fallback
{% endhighlight %}

Feel in the the `$WIFI_SSID` and `$WIFI_PASSWORD`

{% highlight bash %}
$ vi /etc/network/interfaces
allow-hotplug wlan0
auto wlan0

iface wlan0 inet dhcp
        wpa-ssid "$WIFI_SSID"
        wpa-psk "$WIFI_PASSWORD"
{% endhighlight %}

Bring up the interface and watch it get DHCP

{% highlight bash %}
pi@kr4spberry ~ $ sudo ifup wlan0 
ioctl[SIOCSIWAP]: Operation not permitted
ioctl[SIOCSIWENCODEEXT]: Invalid argument
ioctl[SIOCSIWENCODEEXT]: Invalid argument
Internet Systems Consortium DHCP Client 4.2.2
Copyright 2004-2011 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/
Listening on LPF/wlan0/$MACADDRESS
Sending on   LPF/wlan0/$MACADDRESS
Sending on   Socket/fallback
DHCPDISCOVER on wlan0 to 255.255.255.255 port 67 interval 7
DHCPDISCOVER on wlan0 to 255.255.255.255 port 67 interval 20
DHCPDISCOVER on wlan0 to 255.255.255.255 port 67 interval 15
DHCPREQUEST on wlan0 to 255.255.255.255 port 67
DHCPOFFER from 192.168.0.1
DHCPACK from 192.168.0.1
bound to 192.168.0.11 -- renewal in 1405 seconds.
{% endhighlight %}

#### intermittent  wifi
There is a power saving issue with the wifi intermittently going off, 
Here's how to fix it? 

Create and edit a new file in `/etc/modprobe.d/8192cu.conf`
{% highlight bash %}
 sudo nano /etc/modprobe.d/8192cu.conf
{% endhighlight %}

and paste the following in
{% highlight bash %}
 # Disable power saving
options 8192cu rtw_power_mgnt=0 rtw_enusbss=1 rtw_ips_mode=1
{% endhighlight %}

Then reboot with `sudo reboot`

#### Wifi / HEADLESS
I intended to use this as a headless server. 
I run quick nmap scans on my network and I compare the matching MAC Address

`sudo nmap -F 192.168.0.0/24`

{% highlight bash %}
$IP
Host is up (0.064s latency).
MAC Address: $MACADDRESS (Kaparel)

{% endhighlight %}

now once dongle is connected on the network I can scan for it. 
{% highlight bash %}
$ifconfig
wlan0     Link encap:Ethernet  HWaddr 00:0b:81:94:ed:70  
          inet addr:$IP-PREFIX.7  Bcast:$IP-PREFIX.255  Mask:255.255.255.0
{% endhighlight %}

TODO:
* learn a way to connect to known netowrks automatically, and cron to keep retrying link when it goes down