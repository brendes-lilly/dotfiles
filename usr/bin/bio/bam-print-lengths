#!/bin/sh
echo "$1"
samtools view "$1" | awk '{ print length($10) }' | head | sort -u
