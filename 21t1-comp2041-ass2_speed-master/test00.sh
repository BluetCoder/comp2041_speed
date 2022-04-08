#!/bin/dash

speed_output=$(seq 1 5 | ./speed.pl '2q')
expected_output_1="1
2"
if [ "$speed_output" = "$expected_output_1" ] ;then
	echo "Passed quit01 command test"
else
	echo "Failed quit01 command test"
	echo "Expected output is:"
	echo "$expected_output_1"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 5 | ./speed.pl '/^2/q')
expected_output_2="1
2"
if [ "$speed_output" = "$expected_output_2" ] ;then
	echo "Passed quit02 command test"
else
	echo "Failed quit02 command test"
	echo "Expected output is:"
	echo "$expected_output_2"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 5 | ./speed.pl 'q')
expected_output_3="1"
if [ "$speed_output" = "$expected_output_3" ] ;then
	echo "Passed quit03 command test"
else
	echo "Failed quit03 command test"
	echo "Expected output is:"
	echo "$expected_output_3"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
