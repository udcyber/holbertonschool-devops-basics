#!/usr/bin/env bash

# Display a concise overview of every network interface
# and its assigned addresses.

ip -br -4 addr | awk '{print $1, $2, $3}'
