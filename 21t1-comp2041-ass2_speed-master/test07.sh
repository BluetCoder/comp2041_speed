#!/bin/dash
speed_output=$(seq 1000 1010 | ./speed.pl 'sW00WW')
expected_output="10
11
12
13
14
15
16
17
18
19
1010"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed substitute non whitespace 01 command test"
else
	echo "Failed substitute non whitespace 01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(echo "Peter Piper pecked Pillow" | ./speed.pl 's>P>W>g')
expected_output="Weter Wiper pecked Willow"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed substitute non whitespace 02 command test"
else
	echo "Failed substitute non whitespace 02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 10 | ./speed.pl '5sS5SfiveSg')
expected_output="1
2
3
4
five
6
7
8
9
10"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed substitute non whitespace command 03 test"
else
	echo "Failed substitute non whitespace command 03 test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
speed_output=$(seq 100 110 | ./speed.pl '$s!0!|!')
expected_output="100
101
102
103
104
105
106
107
108
109
11|"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed substitute non whitespace command 04 test"
else
	echo "Failed substitute non whitespace command 04 test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
