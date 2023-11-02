#!/bin/bash

if [ -f "clang_output.txt" ];
then
	if [ -s "clang_output.txt" ];
	then
        echo "FAIL"
        exit 1
        fi
	else
		echo "Style test OK"
	fi