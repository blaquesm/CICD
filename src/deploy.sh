#!/bin/bash

scp $(find -type f -perm /a=x -name "s21_cat"|tail -1) blaq@10.10.0.2:/usr/local/bin
scp $(find -type f -perm /a=x -name "s21_grep"|tail -1) blaq@10.10.0.2:/usr/local/bin
ssh blaq@10.10.0.2 ls /usr/local/bin