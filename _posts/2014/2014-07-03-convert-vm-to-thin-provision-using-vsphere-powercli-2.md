---
layout:
title: "Convert vm to thin-Provision using vSphere PowerCLI"
date: 2014-07-03 13:22 -0400
categories: [virtualization]
tags: powercli  vmware
status: publish
type: post
published: true
meta:
  _oembed_71b7143244fe16b0a7f4e639ee2b2a95: "{{unknown}}"
  _oembed_af6a7b38ed7b28bdb7a33085136dcbc0: "{{unknown}}"
  _oembed_de403bbc320cc82fd8cfec40144a911f: "{{unknown}}"
  _edit_last: '7257748'
  geo_public: '0'
  _publicize_pending: '1'
excerpt_separator: <!--more-->
---

<p>Unfortunately in VCenter 5.1 there is no way to move a hard drive attached to a vm from thick provisioned to thin. The hack right now is to move drive into a different datastore, and while moving it change its hard drive type value.</p>

<p>first a quick way to list all the servers you have that are thin-provisioned.

{% highlight powershell %}
get-vm | get-view | select name,@{N='ThinProvisioned';E={$_.config.hardware.Device.Backing.ThinProvisioned } }
{% endhighlight %}

<p>or export them

{% highlight powershell %}
get-vm | get-view | select name,@{N='ThinProvisioned';E={$_.config.hardware.Device.Backing.ThinProvisioned } } |Export-Csv "c:\ThinProvisioned.csv"
{% endhighlight %}

or filter them, to solely capture the servers that aren't thin provisioned</p>

{% highlight powershell %}
$report = @()
foreach ($vm in Get-VM){
    if ($vm.PowerState -eq 'PoweredOn'){
        $vm.name
        $view = Get-View $vm
        foreach ($item in $view.config.hardware.Device.Backing.ThinProvisioned){
            if ($item -eq $false){
                $row = "" | select Name, Thin
                $row.Name = $vm.Name
                $row.Thin = $view.config.hardware.Device.Backing.ThinProvisioned | Out-String
                $report += $row
}}}}
$report | Sort Name |Export-Csv "c:\ThinProvisioned.csv"
{% endhighlight %}

<p>we have a vm1, we are trying to move it's hard-drive

{% highlight powershell %}
vSphere PowerCLI> $vm = 'vm1'
vSphere PowerCLI> Get-VM $vm | Get-harddisk

CapacityGB Persistence Filename
---------- ----------- --------
34.000 Persistent [server_vmfs02] vm1/vm1.vmdk
34.000 Persistent [server_vmfs02] vm1/vm1_1.vmdk
16.000 Persistent [server_vmfs02] vm1/vm1_2.vmdk

vSphere PowerCLI> Get-VM $vm

Name PowerState Num CPUs MemoryGB
---- ---------- -------- --------
vm1  PoweredOn      2      4.000
{% endhighlight %}

<p>as you can see 'vm1' is in my 'vmfs02' datastore, therefore will move it to my vmfs_03 data store and in the process make it thin.
<strong>warning -Confirm:$false will move without asking you to confirm</strong>

{% highlight powershell %}
$myDatastore1 = Get-Datastore server1_vmfs_03
$myDisk = Get-VM -Name $vm | Get-HardDisk
Move-HardDisk -HardDisk $myDisk -Datastore $myDatastore1 -StorageFormat Thin -Confirm:$false
{% endhighlight %}

<p>The code below isn't the best solution, but for now it does the work. I know I have 4 datastores, and if server isn't one, must be in  another. Later when my stores grow I'll have more targetted rules, like preserving affinity rules</p>

<strong>Code does not work for all cases, read below </strong>

{% highlight powershell %}
Import-Csv C:\ConvertThem2.csv |
Foreach {
    $vm = $_.name
    $myDisk = Get-VM -Name $vm | Get-HardDisk
    $view = Get-VM -Name $vm | Get-View
    foreach ($item in $view.config.hardware.Device.Backing){
        if ($item.ThinProvisioned -eq $false){
            $datastore = $item.Filename.split('[')[1].split(']')[0]

            if ($datastore -eq "server_vmfs01"){
                $destDatastore = Get-Datastore server_vmfs02
            }
            Elseif ($datastore -eq "server_vmfs02"){
                $destDatastore = Get-Datastore server_vmfs03
            }
            Elseif ($datastore -eq "server_vmfs03"){
                $destDatastore = Get-Datastore server_vmfs04
            }
            Elseif ($datastore -eq "server_vmfs04"){
                $destDatastore = Get-Datastore server_vmfs01
            }

            $myDisk=Get-HardDisk -Datastore $datastore -DatastorePath $item.Filename
            Move-HardDisk -HardDisk $myDisk -Datastore $destDatastore -StorageFormat Thin -Confirm:$false
        }
    }
}
{% endhighlight %}

<p>It is good to learn from one's mistake.
The code above doesn't always work for a simple reason,
[https://communities.vmware.com/message/1679783/] (https://communities.vmware.com/message/1679783/) </p>

<p>When a hard disk is directly retrieved from a datastore there isn't enough information to determine whether it's attached to a VM or not. there needs to be a direct retrieval of the disks from the VMs to fully support moving a vm. </p>

Also while digging further, I've found a new way to select vms and their drives.

{% highlight powershell %}
Get-VM -Name $vm | Get-HardDisk | where {$_.StorageFormat -ne 'Thin'}
{% endhighlight %}

this allows me to select disk direcly. `RunAsync` watch out for this flag, it will perform task in background and asynchronously.

`Import-Csv C:\ConvertThem3.csv` as you can see I import the vms from a spreadsheet. all that spreadsheet has is a field called Name and below vms.

{% highlight powershell %}
Import-Csv C:\ConvertThem3.csv |
Foreach {
    $vm = $_.name
    $thickDisk = Get-VM -Name $vm | Get-HardDisk | where {$_.StorageFormat -ne 'Thin'}
    $view = Get-VM -Name $vm | Get-View
    foreach ($disk in $thickDisk){
        $datastore = $disk.Filename.split('[')[1].split(']')[0]
        if ($datastore -eq "server_vmfs01"){
            $destDatastore = Get-Datastore -Name 'server_vmfs02'
        }
        Elseif ($datastore -eq "server_vmfs02"){
            $destDatastore = Get-Datastore -Name 'server_vmfs03'
        }
        Elseif ($datastore -eq "server_vmfs03"){
            $destDatastore = Get-Datastore -Name 'server_vmfs04'
        }
        Elseif ($datastore -eq "server_vmfs04"){
            $destDatastore = Get-Datastore -Name 'server_vmfs01'
        }

        $destDatastore
        Move-HardDisk -HardDisk $Disk -Datastore $destDatastore -StorageFormat Thin -RunAsync -confirm:$false
    }
}
{% endhighlight %}
