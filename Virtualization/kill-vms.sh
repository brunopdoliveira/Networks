#!/bin/bash

ps aux | grep qemu-system-x86_64 | grep -v grep | awk '{print "kill -9",$2," ; # "$NF}' | bash