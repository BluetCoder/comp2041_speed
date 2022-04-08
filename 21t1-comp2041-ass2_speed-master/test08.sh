#!/bin/dash

speed_output=$(seq 1 11 | ./speed.pl '/1/p;10d')
expected_output="1
1
2
3
4
5
6
7
8
9
10
11
11"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed Multiple commands 01 command test"
else
	echo "Failed Multiple commands 01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 10 100 | ./speed.pl '5p;/.[123456789]/d
21q')
expected_output="10
14
20
30"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed Multiple commands 02 command test"
else
	echo "Failed Multiple commands 02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
