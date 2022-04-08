#!/bin/dash

speed_output=$(seq 1 10 | ./speed.pl '-n' '2,5p')
expected_output="2
3
4
5"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed address range 01 command test"
else
	echo "Failed address range 01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 10 | ./speed.pl '-n' '/2/,5p')
expected_output="2
3
4
5"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed address range 02 command test"
else
	echo "Failed address range 02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 10 | ./speed.pl '-n' '2,/5/p')
expected_output="2
3
4
5"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed address range 03 command test"
else
	echo "Failed address range 03 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 20 | ./speed.pl '-n' '/2/,/5/p')
expected_output="2
3
4
5
12
13
14
15
20"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed address range 04 command test"
else
	echo "Failed address range 04 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
