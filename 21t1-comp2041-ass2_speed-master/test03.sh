#!/bin/dash

speed_output=$(seq 1000 1010 | ./speed.pl 's/00//')
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
	echo "Passed substitute01 command test"
else
	echo "Failed substitute01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(echo "Peter Piper pecked Pillow" | ./speed.pl 's/P/W/g')
expected_output="Weter Wiper pecked Willow"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed substitute02 command test"
else
	echo "Failed substitute02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

speed_output=$(seq 1 10 | ./speed.pl '5s/5/five/g')
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
	echo "Passed substitue03 command test"
else
	echo "Failed substitute03 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
speed_output=$(seq 100 110 | ./speed.pl '/.0./s/0/|/')
expected_output="1|0
1|1
1|2
1|3
1|4
1|5
1|6
1|7
1|8
1|9
110"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed substitue04 command test"
else
	echo "Failed substitute04 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0
