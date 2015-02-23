# Puppet dmsetup module

Provides dmsetup features for puppet.

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Development - Guide for contributing to the module](#development)

## Overview

dmsetup manages logical devices that use the device-mapper driver.
LVM, cryptsetup, multipath-tools and other use dmsetup and device-mapper to
setup and manage the devices.

## Module Description

So far this module only contains a facter module to retrieve ls/info/deps
information from dmsetup.

## Development

Please fork on github and send pull requests.

