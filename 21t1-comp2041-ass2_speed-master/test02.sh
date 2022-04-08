#!/bin/dash

speed_output=$(seq 1 11 | ./speed.pl '10d')
expected_output="1
2
3
4
5
6
7
8
9
11"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed delete01 command test"
else
	echo "Failed delete01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 10 100 | ./speed.pl '/.[123456789]/d')
expected_output="10
20
30
40
50
60
70
80
90
100"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed delete02 command test"
else
	echo "Failed delete02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 1000 | ./speed.pl 'd')
expected_output=""
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed delete03 command test"
else
	echo "Failed delete03 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
