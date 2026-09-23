#!/usr/bin/env bash

# Display a concise overview of every network interface
# and its assigned addresses.

#!/bin/bash
# list_interfaces.sh - List network interfaces (works without ip/ifconfig)

echo "=== Interfaces ==="
ls /sys/class/net/

echo
echo "=== Details ==="
for iface in /sys/class/net/*; do
  name=$(basename "$iface")
  state=$(cat "$iface/operstate" 2>/dev/null || echo "?")
  mac=$(cat "$iface/address" 2>/dev/null || echo "n/a")
  printf "%-10s  state=%-8s  mac=%s\n" "$name" "$state" "$mac"
done

echo
echo "=== Traffic stats ==="
cat /proc/net/dev
