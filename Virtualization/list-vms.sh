#!/bin/bash 

ps aux | grep qemu-system-x86_64 | grep -v grep | awk '{print "PID: ",$2," ; # vm : "$NF}'
