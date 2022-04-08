#!/bin/dash
echo "5p" > "commands.speed"
echo "6q" >> "commands.speed"
speed_output=$(seq 1 11 | ./speed.pl '-f' 'commands.speed')
expected_output="1
2
3
4
5
5
6"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed commands file 01 command test"
else
	echo "Failed commands file 01 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi

echo "4d;s/2/3/" >> "commands.speed"
speed_output=$(seq 1 11 | ./speed.pl '-f' 'commands.speed')
expected_output="1
3
3
5
5
6"
if [ "$speed_output" = "$expected_output" ] ;then
	echo "Passed commands file 02 command test"
else
	echo "Failed commands file 02 command test"
	echo "Expected output is:"
	echo "$expected_output"
	echo "Your output"
	echo "$speed_output"
	exit 1
fi
exit 0

