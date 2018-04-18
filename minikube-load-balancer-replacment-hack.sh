#!/bin/sh

# this is just an example
# you need to edit this file to use correct node IP and service node ports
socat -d -d TCP-LISTEN:8081,fork TCP:192.168.99.102:31780 &
socat -d -d TCP-LISTEN:11113,fork TCP:192.168.99.102:31266 &
socat -d -d TCP-LISTEN:4007,fork TCP:192.168.99.102:30114 &
socat -d -d TCP-LISTEN:4006,fork TCP:192.168.99.102:30457 &
