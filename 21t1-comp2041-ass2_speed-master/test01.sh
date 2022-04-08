#!/bin/dash

speed_output=$(seq 1 11 | ./speed.pl '10p')
expected_output="1
2
3
4
5
6
7
8
9
10
10
11"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed print01 command test"
else
	echo "Failed print01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 11 20 | ./speed.pl '/[456]/p')
expected_output="11
12
13
14
14
15
15
16
16
17
18
19
20"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed print02 command test"
else
	echo "Failed print02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 25 30 | ./speed.pl 'p')
expected_output="25
25
26
26
27
27
28
28
29
29
30
30"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed print03 command test"
else
	echo "Failed print03 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
