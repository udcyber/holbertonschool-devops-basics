#!/usr/bin/env bash
ping -c 4 "$(ip -brief -4 address show scope host | tr -s ' ' | cut -d' ' -f3 | cut -d/ -f1 | head -n 1)"
