#!/usr/bin/bash

 cat chr22.unphased.bim | perl -lane '$F[1]="$F[0].":".$F[3]; print join("\t",@F);'> ~/output/renamed.txt

