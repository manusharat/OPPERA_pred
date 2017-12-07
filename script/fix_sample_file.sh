#!/usr/bin/bash

cd ~/output/shapeit/oppera.phased
var="0 0 0 D D D D"
for chrom in {1..22}
do
sed -i "2s/.*/$var/" chr$chrom.phased.sample
done
