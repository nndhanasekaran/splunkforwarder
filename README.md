# splunk

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with splunk](#setup)
    * [What splunk affects](#what-splunk-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with splunk](#beginning-with-splunk)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module will install, configure and manage splunk universal forwarder. Uses rpm to install the splunk forwarder.
It is compatible for RedHat 5, 6 & 7. 

## Module Description

It will create splunk user, then it will install splunk universal forwarder from rpm (not from yum). <br>
Default it will install in /home/splunk location, used --prefix=/home/splunk as install_options. <br>
Then creates sym link from /opt/splunkforwarder to /home/splunk/splunkforwarder. <br>
Change the default password after installing package first time.
Make sure splunk_bindip parameter in splunk-launch.conf present.
Create init.d script from template.
Last it will make sure splunk service is up and running always.

## Setup

### What splunk affects

/home/splunk
/opt/splunkforwarder/*
/etc/init.d/splunk

### Setup Requirements **OPTIONAL**

splunkforwarder rpm location

### Beginning with splunk

The very basic steps needed for a user to get the module up and running.

   class { 'splunkuf' : }

## Usage

   class { 'splunkuf::service' :
     service_ensure => 'stopped',
     service_enable => false,
    }
    
## Reference

  $targeturi      = 'deploymentserver.example.com:8089',
  $mgmthostport   = undef,
  $rpmsrc         = 'http://deploymentserver.example.com:8000/splunk/splunkforwarder-latest.rpm',
  $system_user    = 'splunk',
  $splunk_home    = '/home/splunk',
  $package_ensure = 'installed',
  $service_ensure = 'running',
  $service_enable = true

## Limitations

Tested on RedHat/CentOS 5, 6 & 7

## Development

Working on to add yum installation to install in different location

## Release Notes/Contributors/Etc **Optional**


