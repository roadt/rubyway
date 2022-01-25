#!/bin/bash

# for each $i, bundle --gemfile=$i

for i in $@; do 
    bundle --gemfile=$i
done
