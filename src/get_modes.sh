#!/bin/bash

( 
	cvt 1920 1080
	cvt -r 1920 1080
	cvt 1600 900
	cvt -r 1600 900
	cvt 1360 768
	cvt -r 1360 768
	cvt 1280 720
	cvt -r 1280 720
) | grep -v \# | sed 's/\([ ]\+\)/ /g' | \
tr -d '"' | tr ' ' ',' > ~/Desktop/modes.csv

( 
	cvt 1920 1080 50
	cvt 1600 900 50
	cvt 1360 768 50
	cvt 1280 720 50
) | grep -v \# | sed 's/\([ ]\+\)/ /g' | \
tr -d '"' | tr ' ' ',' >> ~/Desktop/modes.csv
