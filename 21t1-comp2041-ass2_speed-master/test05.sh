#!/bin/dash

speed_output=$(seq 1000 20000 | ./speed.pl '-n' '$p')
expected_output="20000"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed last address 01 command test"
else
	echo "Failed last address 01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 10 | ./speed.pl '$d')
expected_output="1
2
3
4
5
6
7
8
9"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed last address 02 command test"
else
	echo "Failed last address 02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 10 | ./speed.pl '$s/0/99/')
expected_output="1
2
3
4
5
6
7
8
9
199"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed last address 03 command test"
else
	echo "Failed last address 03 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 5 | ./speed.pl '$q')
expected_output="1
2
3
4
5"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed last address 04 command test"
else
	echo "Failed -n command line 04 command test"
	echo "Expected output is:"
	echo "$expected_output_3"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
