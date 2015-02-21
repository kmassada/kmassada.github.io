---
layout: post
title: "Raspberry Pi2"
modified:
categories: raspberrypi2
excerpt:
tags: []
date: 2015-02-19T23:35:01-05:00
---

Rasbsperry pi needs no introduction, regardless of what side of the house you are
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
2. The rasbperry comes with and HDMI port
* You may need an hdmi cable or convertor if your screen does not support hdmi
3. You need a USB keyboard and a mouse 
4. The raspbery pi comes with an ethernet port. 
* You may need an rj-45 cable/ standard ethernet cable
* You also may need to set it up, where you have access to an ethernet jack
5. Case is not a must, but a nice have. 
* I will be moving the pi between home and work, so I found it fitting to have a case
6. You need a 5V micro USB power supply to power the Pi. Most micro-usbs are 5V, read labels.
7. Wi-Fi dongle. (when purchasing, make sure you look into drivers support first)
* One of my priorities with the pi is portability. and this offers just that.  
8. Read manual very carefully, especially power warnings


### Picking an image 

Raspberry comes with many images for noobs, I however chose a standard debian, image ([RASPBIAN](http://raspbian.org/)). Came second to the Fedora counter-part [PIDORA](http://pidora.ca/). 

I've not done due dilligence to find more images, I'm more eager to just get going. 

### Honorable mention

Ubuntu anounced a dev-core image called [Snappy](http://www.markshuttleworth.com/archives/1434), it is meant to be a be minimal server image with the same libraries as traditional ubuntu server. This is still in alpha phases. 

I tried being a maverick, I've had little success getting my wi-Fi dongle to work. 

But like expected the internals are very similar with ubuntu. 

Snappy also includes an easy to configure Web Device Management framework (WEBDM) to manage "snaps" add-ons on your OS. Here's a (good guide)[http://blog.sergiusens.org/posts/Snappy%20Things/] that better describes webdm

And here's [ubuntu's guide to snappy](https://developer.ubuntu.com/en/snappy/)

### Building the image

This the official guide for installing images on linux: http://www.raspberrypi.org/documentation/installation/installing-images/linux.md

Once sdcard is in it's adapter and loaded into your computer, 

you can run the following commands to see what's mounted.
`df -h`

My sdcard mount point is mmcblk0p1, unmount it first
`umount /dev/mmcblk0p1`

Once you have downloaded an image at http://www.raspberrypi.org/downloads/ 

you can unzip the image using this command 
`unzip 2015-02-16-wheezy-raspbian.zip`

Now you are ready to build the image file `2015-02-16-wheezy-raspbian.img`
**be careful, this is a command that will overwrite a partition if you pick the wrong one, if in doubt refer to official documentation. also note 'mmcblk0' not 'mmcblk0p1,p2'**  
`sudo dd bs=4M if=2015-02-16-wheezy-raspbian.img of=/dev/mmcblk0`

sync, to reload cache, and remove sdcard
`sync`

### Starting the image [RASPBIAN]

Once sdcard inserted. power the Pi by insterting the power cable. 

RASPBIAN setup is self explanatory, it allows you to configure ahead of time, few variables, before the image fully boots. 
<figure>
<img src="/images/pi-raspi-config-main.png">
</figure>

#attempt 3
$ sudo ifdown wlan0
Internet Systems Consortium DHCP Client 4.2.2
Copyright 2004-2011 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/wlan0/00:0b:81:94:ed:70
Sending on   LPF/wlan0/00:0b:81:94:ed:70
Sending on   Socket/fallback
pi@kr4spberry ~ $ sudo ifup wlan0 
ioctl[SIOCSIWAP]: Operation not permitted
ioctl[SIOCSIWENCODEEXT]: Invalid argument
ioctl[SIOCSIWENCODEEXT]: Invalid argument
Internet Systems Consortium DHCP Client 4.2.2
Copyright 2004-2011 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/wlan0/00:0b:81:94:ed:70
Sending on   LPF/wlan0/00:0b:81:94:ed:70
Sending on   Socket/fallback
DHCPDISCOVER on wlan0 to 255.255.255.255 port 67 interval 7
DHCPDISCOVER on wlan0 to 255.255.255.255 port 67 interval 20
DHCPDISCOVER on wlan0 to 255.255.255.255 port 67 interval 15
DHCPREQUEST on wlan0 to 255.255.255.255 port 67
DHCPOFFER from 192.168.0.1
DHCPACK from 192.168.0.1
bound to 192.168.0.11 -- renewal in 1405 seconds.

$ vi /etc/network/interfaces
allow-hotplug wlan0
auto wlan0

iface wlan0 inet dhcp
        wpa-ssid "MOTOROLA-E2153"
        wpa-psk "d1c826cb8e9f3c61eebb"

Create and edit a new file in /etc/modprobe.d/8192cu.conf
 sudo nano /etc/modprobe.d/8192cu.conf
and paste the following in
 # Disable power saving
options 8192cu rtw_power_mgnt=0 rtw_enusbss=1 rtw_ips_mode=1
Then reboot with sudo reboot

192.168.0.7
Host is up (0.064s latency).
MAC Address: 00:0B:81:94:ED:70 (Kaparel)
192.168.0.7
wlan0     Link encap:Ethernet  HWaddr 00:0b:81:94:ed:70  
          inet addr:192.168.0.7  Bcast:192.168.0.255  Mask:255.255.255.0
