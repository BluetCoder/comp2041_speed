#!/bin/dash

speed_output=$(seq 25 35 | ./speed.pl '-n' '/2/p')
expected_output="25
26
27
28
29
32"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed -n command line 01 command test"
else
	echo "Failed -n command line 01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 100 | ./speed.pl '-n' 'd')
expected_output=""
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed -n command line 02 command test"
else
	echo "Failed -n command line 02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 1000 | ./speed.pl '-n' 'q')
expected_output=""
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed -n command line 03 command test"
else
	echo "Failed -n command line 03 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 5 | ./speed.pl '-n' '2s/2/two/')
expected_output=""
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed -n command line 04 command test"
else
	echo "Failed -n command line 04 command test"
	echo "Expected output is:"
	echo "$expected_output_3"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
