#!/usr/bin/perl -w
#Global variable
my %commands;
my $output;
my @array_commands;
# Does append command by manipulating output variable
sub do_append_command {
	my ($text) = @_;
	my $original_text = $output;
	$output =~ s/$original_text/$original_text$text\n/g;
}
# Does insert command by manipulating output variable
sub do_insert_command {
	my ($text) = @_;
	my $original_text = $output;
	$output =~ s/$original_text/$text\n$original_text/g;
}
# Does change command by manipulating output variable
sub do_change_command {
	my ($text) = @_;
	my $original_text = $output;
	$output =~ s/$original_text/$text\n/g;
}
# Goes through if conditions to determine when to apply subset 2 commands
sub subset2_commands {
	my ($line_number_command, $line_number, $line, $regex, $last_line, $last_line_num, $text, $command) = @_;
	if (defined($line_number_command)) {
		if ($line_number == $line_number_command){
			if ($command eq "a") {
				do_append_command($text);
			} elsif ($command eq "i") {
				do_insert_command($text);
			} elsif ($command eq "c") {
				do_change_command($text);
			}
		}
	} elsif (defined($regex)) {
		if ($line =~ /$regex/){
			if ($command eq "a") {
				do_append_command($text);
			} elsif ($command eq "i") {
				do_insert_command($text);
			} elsif ($command eq "c") {
				do_change_command($text);
			}
		}
	} elsif (defined($last_line)) {
		if ($last_line_num == 1){
			if ($command eq "a") {
				do_append_command($text);
			} elsif ($command eq "i") {
				do_insert_command($text);
			} elsif ($command eq "c") {
				do_change_command($text);
			}
		}
	} else {
		if ($command eq "a") {
			do_append_command($text);
		} elsif ($command eq "i") {
			do_insert_command($text);
		} elsif ($command eq "c") {
			do_change_command($text);
		}
	}
	return 0;
}
# Does quit command by stating when to break the loop by returning 3
sub quit_command {
	my ($line_number_command, $line_number, $line, $regex, $last_line, $last_line_num) = @_;
	if (defined($line_number_command)) {
		if ($line_number == $line_number_command){
			return 3;
		}
	} elsif (defined($regex)) {
		if ($line =~ /$regex/){
			return 3;
		}
	} elsif (defined($last_line)) {
		if ($last_line_num == 1){
			return 3;
		}
	} else {
		return 3;
	}
	return 0;
}
# Does print command by editing $output variable
# Returns 1 to indicate it is between a pattern
# Returns 2 to indicate no pattern matching after the line
sub print_command {
	my ($line_number_command, $line_number, $line, $regex, $command_line_option, $last_line, $last_line_num, $line_number_start, $line_number_end, $line_pattern_start, $in_range_pattern) = @_;
	# These if statements are for address range
	if (defined($line_pattern_start) && $in_range_pattern == 0) {
		if ($line =~ /$line_pattern_start/) {
			$output = "$output$output";
			if (defined($command_line_option)) {
				if ($command_line_option eq "-n") {
					$output = $line;
				}
			}
			return 1;
		}
	} elsif (defined($line_number_start) && $in_range_pattern == 0) {
		if ($line_number == $line_number_start) {
			$output = "$output$output";
			if (defined($command_line_option)) {
				if ($command_line_option eq "-n") {
				$output = $line;
				}
			}
			return 1;
		}
	} elsif (defined($line_number_end) && $in_range_pattern == 1) {
		if ($line_number == $line_number_end) {
			$output = "$output$output";
			if (defined($command_line_option)) {
				if ($command_line_option eq "-n") {
					$output = $line;
				}
			}
			return 2;
		} else {
			$output = "$output$output";
			if (defined($command_line_option)) {
				if ($command_line_option eq "-n") {
					$output = $line;
				}
			}
			return 1;
		}
	} elsif (defined($line_number_start) || defined($line_pattern_start)) {
		if ($in_range_pattern == 1) {
			if (defined($regex)) {
				if ($line =~ /$regex/) {
				} else {
					$output = "$output$output";
					if (defined($command_line_option)) {
						if ($command_line_option eq "-n") {
							$output = $line;
						}
					}
					return 1;
				}
			}
		}
	}
	# These if statements are for other print conditions. Also considers range of lines
	if (defined($line_number_command)) {
		if ($line_number == $line_number_command){
			$output = "$output$output";
			if (defined($command_line_option)) {
				if ($command_line_option eq "-n") {
					$output = $line;
				}
			}
		}
	} elsif (defined($regex)) {
		if ($line =~ /$regex/){
			if ($in_range_pattern == 1) {
				if (defined($line_pattern_start)) {
					$output = "$output$output";
					if (defined($command_line_option)) {
						if ($command_line_option eq "-n") {
						$output = $line;
						}
					}
					return 0;
				} else {
					$output = "$output$output";
					if (defined($command_line_option)) {
						if ($command_line_option eq "-n") {
							$output = $line;
						}
					}
					return 2;
				}
			} elsif ($in_range_pattern == 2) {
				$output = "$output$output";
				if (defined($command_line_option)) {
					if ($command_line_option eq "-n") {
						$output = $line;
					}
				}
				return 2;
			} elsif (defined($line_number_end)) {
				$output = "$output$output";
				if (defined($command_line_option)) {
					if ($command_line_option eq "-n") {
						$output = $line;
					}
				}
				return 1;
			} else {
				$output = "$output$output";
				if (defined($command_line_option)) {
					if ($command_line_option eq "-n") {
						$output = $line;
					}
				}
			}
		}
	} elsif (defined($last_line)) {
		if ($last_line_num == 1) {
			$output = "$output$output";
			if (defined($command_line_option)) {
				if ($command_line_option eq "-n") {
					$output = $line;
				}
			}
		} 
	} elsif (defined($line_number_end) || defined($line_number_start) || defined($line_pattern_start)) {
	} else {
		$output = "$output$output";
		if (defined($command_line_option)) {
			if ($command_line_option eq "-n") {
				$output = $line;
			}
		}
	}
	return 0;
}
# Does delete command by editing $output variable
# Returns 1 to indicate it is between a pattern
# Returns 2 to indicate no pattern matching after the line
# Returns 3 to break the loop
# Returns 0 otherwise
sub delete_command {
	my ($line_number_command, $line_number, $line, $regex, $last_line, $last_line_num, $line_number_start, $line_number_end, $line_pattern_start, $in_range_pattern) = @_;
	# These if statements are for address range
	if (defined($line_pattern_start) && $in_range_pattern == 0) {
		if ($line =~ /$line_pattern_start/) {
			$output =~ s/$line//;
			return 1;
		}
	} elsif (defined($line_number_start) && $in_range_pattern == 0) {
		if ($line_number == $line_number_start) {
			$output =~ s/$line//;
			return 1;
		}
	} elsif (defined($line_number_end) && $in_range_pattern == 1) {
		if ($line_number == $line_number_end) {
			$output =~ s/$line//;
			return 2;
		} else {
			$output =~ s/$line//;
			return 1;
		}
	} elsif (defined($line_number_start) || defined($line_pattern_start)) {
		if ($in_range_pattern == 1) {
			if (defined($regex)) {
				if ($line =~ /$regex/) {
				} else {
					$output =~ s/$line//;
					return 1;
				}
			}
		}
	}
	# These if statements are for other delete conditions. Also considers range of lines
	if (defined($line_number_command)) {
		if ($line_number == $line_number_command){
			$output =~ s/$line//;
		}
	} elsif (defined($regex)) {
		if ($line =~ /$regex/) {
			if ($in_range_pattern == 1) {
				if (defined($line_pattern_start)) {
					$output =~ s/$line//;
					return 0;
				} else {
					$output =~ s/$line//;
					return 2;
				}
			} elsif ($in_range_pattern == 2) {
				return 2;
			} elsif (defined($line_number_end)) {
				$output =~ s/$line//;
				return 1;
			}

			$output =~ s/$line//;
		}
	} elsif (defined($last_line)) {
		if ($last_line_num == 1) {
			$output =~ s/$line//;
		}
	} else {
		if (defined($line_number_start) || defined($line_number_end)) {
		} else {
			$output =~ s/$line//;
			return 3;
		}
	}
	return 0;
}

# Does the substitute command by editing output variable
sub do_substitute_command {
	my ($line, $pattern_1, $pattern_2, $modifier) = @_;
	$edited_line = $line;
	if ($line =~ /$pattern_1/) {
		if ($modifier == 0) {
			$edited_line =~ s/$pattern_1/$pattern_2/;
		} else {
			$edited_line =~ s/$pattern_1/$pattern_2/g;
		}
		$output =~ s/$line/$edited_line/g;
	}
}
# Goes through conditions before conducting substitute command
# Returns 1 to indicate it is between a pattern
# Returns 2 to indicate no pattern matching after the line
# Returns 3 to break the loop
# Returns 0 otherwise
sub substitute_command {
	my ($line_number_command, $line_number, $line, $regex, $pattern_1, $pattern_2, $modifier, $last_line, $last_line_num, $line_number_start, $line_number_end, $line_pattern_start, $in_range_pattern) = @_;
	# These if statements are for address range
	if (defined($line_pattern_start) && $in_range_pattern == 0) {
		if ($line =~ /$line_pattern_start/) {
			do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
			return 1;
		}
	} elsif (defined($line_number_start) && $in_range_pattern == 0) {
		if ($line_number == $line_number_start) {
			if ($line =~ /$line_pattern_start/) {
				do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
				return 1;
			}
			return 1;
		}
	} elsif (defined($line_number_end) && $in_range_pattern == 1) {
		if ($line_number == $line_number_end) {
			do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
			return 2;
		} else {
			do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
			return 1;
		}
	} elsif (defined($line_number_start) || defined($line_pattern_start)) {
		if ($in_range_pattern == 1) {
			if (defined($regex)) {
				if ($line =~ /$regex/) {
				} else {
					do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
					return 1;
				}
			}
		}
	}
	# These if statements are for other substitute conditions. Also considers range of lines
	if (defined($line_number_command)) {
		if ($line_number != $line_number_command) {
			return 0;
		}
	} elsif (defined($regex)) {
		if ($line =~ /$regex/) {
			if ($in_range_pattern == 1) {
				if (defined($line_pattern_start)) {
					do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
					return 0;
				} else {
					do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
					return 2;
				}
			} elsif ($in_range_pattern == 2) {
				return 2;
			} elsif (defined($line_number_end)) {
				do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
				return 1;
			}
		} else {
			return 0;
		}
	} elsif (defined($last_line)) {
		if ($last_line_num != 1) {
			return 0;
		}
	}
	do_substitute_command($line, $pattern_1, $pattern_2, $modifier);
	return 0;
}

#Checks if key exists and returns the value if it exists
# Returns undef otherwise
sub check_key {
	my ($key, $i) = @_;
	if (exists($array_commands[$i]{"$key"})) {
		return $array_commands[$i]{"$key"};
	} else {
		return undef;
	}
}
# main
# Checking and organise arguments to prepare for the interpretation of addresses
$num_arguments = $#ARGV + 1;
my $command_line_option;
if ($num_arguments == 1) {
	$address = $ARGV[0];
} elsif ($num_arguments > 1) {
	if ($ARGV[0] =~ /^-/) {
		$command_line_option = $ARGV[0];
	}
	if (defined($command_line_option)) {
		if ($command_line_option eq "-f") {
			$command_file = $ARGV[1];
		} elsif ($command_line_option eq "-n") {
			if ($ARGV[1] =~ /-f/) {
				$command_file = $ARGV[2];
			} else {
				$address = $ARGV[1];
			}
		} else {
			$address = $ARGV[1];
		}
	}
}
my @addresses;
if(defined($command_file)) {
	open($read_command_file, '<', $command_file) or die $!;
	@unfiltered_commands = <$read_command_file>;
	close($read_command_file);
	$i = 0;
	foreach my $command (@unfiltered_commands) {
		if ($command =~ /;/) {
			my @multiple_commands = split /[;]/, $command;
			foreach my $split_command (@multiple_commands) {
				$split_command =~ s/\n$//;
				$addresses[$i] = $split_command;
				$i++;
			}
		} else {
			$command =~ s/\n$//;
			$addresses[$i] = $command;
			$i++;
		}
	}
} else {
	@addresses = split /[;\n]/, $address;
}
# Interpret addresses
$i = 0;
foreach my $address (@addresses) {
	# Substitute command regex
	if ($address =~ /s(\S)(.+)\S(.*)\S(\w)?$/) {
		$non_white_space = $1;
		$commands{"$address"}{"command"} = "s";
		$commands{$address}{"in_range_pattern"} = 0;
		# Recognises :
		# seq 1 5 | ./speed.pl 's/[15]/zzz/'
		# seq 51 60 | ./speed.pl '5s/5/9/g'
		# seq 51 60 | ./speed.pl '$s/5/9/g'
		if ($address =~ /^([\d+ \$])?s$non_white_space(.*)$non_white_space(.*)$non_white_space(\w)?$/) {
			if (defined($1)) {
				if ($1 eq "\$") {
					$commands{"$address"}{"last_line"} = $1;
				} elsif ($1 ne "") {
					$commands{"$address"}{"line_number_command"} = $1;
				}
			}
			$commands{"$address"}{"pattern_1"} = $2;
			$commands{"$address"}{"pattern_2"} = $3;
			$commands{"$address"}{"modifier"} = 0;
			$modifier = 0;
			if (defined($4)){
				$commands{"$address"}{"modifier"} = 1;
			}
		# Recognises :
		# seq 1 5 | ./speed.pl '2,5s/[15]/zzz/'
		} elsif ($address =~ /^(\d*),(\d*)s$non_white_space(.*)$non_white_space(.*)$non_white_space(\w)?$/) {
			$commands{"$address"}{"line_number_start"} = $1;
			$commands{"$address"}{"line_number_end"} = $2;
			$commands{"$address"}{"pattern_1"} = $3;
			$commands{"$address"}{"pattern_2"} = $4;
			$commands{"$address"}{"modifier"} = 0;
			if (defined($5)) {
				$commands{"$address"}{"modifier"} = 1;
			}
		# Recognises :
		# seq 1 5 | ./speed.pl '/2/,/5/s/[15]/zzz/'
		} elsif ($address =~ /^\/(.+)\/,\/(.+)\/s$non_white_space(.*)$non_white_space(.*)$non_white_space(\w)?$/) {
			$commands{"$address"}{"line_pattern_start"} = $1;
			$commands{"$address"}{"regex"} = $2;
			$commands{"$address"}{"pattern_1"} = $3;
			$commands{"$address"}{"pattern_2"} = $4;
			$commands{"$address"}{"modifier"} = 0;
			if (defined($5)) {
				$commands{"$address"}{"modifier"} = 1;
			}
		# Recognises :
		# seq 1 5 | ./speed.pl '1,/5/s/[15]/zzz/'
		} elsif ($address =~ /^(\d+),\/(.+)\/s$non_white_space(.*)$non_white_space(.*)$non_white_space(\w)?$/) {
			$commands{"$address"}{"line_number_start"} = $1;
			$commands{"$address"}{"regex"} = $2;
			$commands{"$address"}{"pattern_1"} = $3;
			$commands{"$address"}{"pattern_2"} = $4;
			$commands{"$address"}{"modifier"} = 0;
			if (defined($5)){
				$commands{"$address"}{"modifier"} = 1;
			}
		# Recognises :
		# seq 1 5 | ./speed.pl '/1/,5s/[15]/zzz/'
		} elsif ($address =~ /^\/(.*)\/,(\d+)s$non_white_space(.*)$non_white_space(.*)$non_white_space(\w)?$/) {
			$commands{"$address"}{"regex"} = $1;
			$commands{"$address"}{"line_number_end"} = $2;
			$commands{"$address"}{"pattern_1"} = $3;
			$commands{"$address"}{"pattern_2"} = $4;
			$commands{"$address"}{"modifier"} = 0;
			if (defined($5)){
				$commands{"$address"}{"modifier"} = 1;
			}
		# Recognises :
		# seq 1 5 | ./speed.pl '/1.1/s/[15]/zzz/'
		} elsif ($address =~ /^\/(.*)\/s\/(.*)\/(.*)\/(\w)?$/) {
			$commands{"$address"}{"regex"} = $1;
			$commands{"$address"}{"pattern_1"} = $2;
			$commands{"$address"}{"pattern_2"} = $3;
			$commands{"$address"}{"modifier"} = 0;
			$modifier = 0;
			if (defined($4)) {
				$commands{"$address"}{"modifier"} = 1;
			}
		}
	}
	# Recognises :
	# seq 1 5 | ./speed.pl '/1/,/5/p or d'
	elsif ($address =~ /^\/(.*)\/,\/(.*)\/(\w)$/) {
		$commands{"$address"}{"line_pattern_start"} = $1;
		$commands{"$address"}{"regex"} = $2;
		$commands{"$address"}{"command"} = $3;
		$commands{$address}{"in_range_pattern"} = 0;
	}
	# Recognises :
	# seq 1 5 | ./speed.pl '/1/p or d or q'
	elsif ($address =~ /^\/(.*)\/(\w)$/) {
		$commands{"$address"}{"regex"} = $1;
		$commands{"$address"}{"command"} = $2;
		if ($2 eq "p" || $2 eq "d") {
			$commands{$address}{"in_range_pattern"} = 0;
		}
	}
	# Recognises :
	# seq 1 5 | ./speed.pl '2p or 2d or 2q'
	elsif ($address =~ /^(\d+)(\w)$/) {
		$commands{"$address"}{"line_number_command"} = $1;
		$commands{"$address"}{"command"} = $2;
		if ($2 eq "p" || $2 eq "d") {
			$commands{$address}{"in_range_pattern"} = 0;
		}
	# Recognises
	# seq 10 21 | ./speed '3,5d'
	} elsif ($address =~ /^(\d+)?,(\d+)?([pd])$/) {
		$commands{"$address"}{"line_number_start"} = $1;
		$commands{"$address"}{"line_number_end"} = $2;
		$commands{"$address"}{"command"} = $3;
		$commands{$address}{"in_range_pattern"} = 0;
	# Recognises
	# e.g seq 10 21 | ./speed '/2/,4d'
	} elsif ($address =~ /^\/(.*)\/,(\d+)?([pd])$/) {
		$commands{"$address"}{"line_pattern_start"} = $1;
		$commands{"$address"}{"regex"} = $2;
		$commands{"$address"}{"command"} = $3;
		$commands{$address}{"in_range_pattern"} = 0;
	# Recognises
	# seq 10 21 | ./speed '3,/2/d'
	} elsif ($address =~ /^(\d+),\/(.*)\/([pd])$/) {
		$commands{"$address"}{"line_number_start"} = $1;
		$commands{"$address"}{"regex"} = $2;
		$commands{"$address"}{"command"} = $3;
		$commands{$address}{"in_range_pattern"} = 0;
	# Recognises
	#seq 1 10000 | ./speed -n '$p'
	} elsif ($address =~ /^(\$)(\w)$/) {
		$commands{"$address"}{"last_line"} = $1;
		$commands{"$address"}{"command"} = $2;
		if ($2 eq "p" || $2 eq "d") {
			$commands{$address}{"in_range_pattern"} = 0;
		}
	# Recognises
	#seq 1 10000 | ./speed.pl 'p'
	} elsif ($address =~ /^\w$/) {
		$commands{"$address"}{"command"} = $address;
		if ($address eq "p" || $address eq "d") {
			$commands{$address}{"in_range_pattern"} = 0;
		}
	# Recognises
	#seq 1 10000 | ./speed.pl '3i hello'
	} elsif ($address =~ /^([\d+ \$])(\w)\s(.+)$/) {
		if (defined($1)) {
			if ($1 eq "\$") {
				$commands{"$address"}{"last_line"} = $1;
			} elsif ($1 ne "") {
				$commands{"$address"}{"line_number_command"} = $1;
			}
		}
		$commands{"$address"}{"command"} = $2;
		$commands{"$address"}{"text"} = $3;
	# Recognises
	#seq 1 10000 | ./speed.pl '/1/i hello'
	} elsif ($address =~ /\/(.+)\/(\w)\s(.+)/) {
		$commands{"$address"}{"regex"} = $1;
		$commands{"$address"}{"command"} = $2;
		$commands{"$address"}{"text"} = $3;
	} else {
		print "speed: command line: invalid command\n";
		exit 1;
	}
	$array_commands[$i] = $commands{$address};
	$i++;
}
# Do commands
$line_number = 1;
$last = 0;
$num_commands = $#array_commands + 1;
$last_line_num = 0;
$in_range_pattern = 0;
$line = <STDIN>;
while (1) {
	$next_line = <STDIN>;
	if (defined($next_line)) {  # check for end of last file
    } else {
        $last_line_num = 1;
    }
	$output = "$line";
	if (defined($command_line_option)) {
		if ($command_line_option eq "-n") {
			$output = "";
		}
	}
	# loops through multiple commands
	for (my $i = 0; $i < $num_commands; $i++) {
		if ($array_commands[$i]{"command"} eq "q") {
			$line_number_command = check_key("line_number_command", $i);
			$regex = check_key("regex", $i);
			$last_line = check_key("last_line", $i);
			$last = quit_command($line_number_command, $line_number, $line, 
			$regex, $last_line, $last_line_num);
		} elsif ($array_commands[$i]{"command"} eq "p") {
			$line_number_command = check_key("line_number_command", $i);
			$regex = check_key("regex", $i);
			$last_line = check_key("last_line", $i);
			$line_number_start = check_key("line_number_start", $i);
			$line_number_end = check_key("line_number_end", $i);
			$line_pattern_start = check_key("line_pattern_start", $i);
			$in_range_pattern = $array_commands[$i]{"in_range_pattern"};
			$array_commands[$i]{"in_range_pattern"} = print_command($line_number_command, $line_number, 
			$line, $regex, $command_line_option, $last_line, $last_line_num, 
			$line_number_start, $line_number_end, $line_pattern_start, 
			$in_range_pattern);
		} elsif ($array_commands[$i]{"command"} eq "d") {
			$line_number_command = check_key("line_number_command", $i);
			$regex = check_key("regex", $i);
			$last_line = check_key("last_line", $i);
			$line_number_start = check_key("line_number_start", $i);
			$line_number_end = check_key("line_number_end", $i);
			$line_pattern_start = check_key("line_pattern_start", $i);
			$in_range_pattern = $array_commands[$i]{"in_range_pattern"};
			$in_range_pattern = delete_command($line_number_command, $line_number, $line, $regex, $last_line, $last_line_num, $line_number_start, $line_number_end, $line_pattern_start, $in_range_pattern);
			if ($in_range_pattern eq 3) {
				$last = $in_range_pattern;
			} else {
				$array_commands[$i]{"in_range_pattern"} = $in_range_pattern;
			}
		} elsif ($array_commands[$i]{"command"} eq "s") {
			$line_number_command = check_key("line_number_command", $i);
			$regex = check_key("regex", $i);
			$pattern_1 = check_key("pattern_1", $i);
			$pattern_2 = check_key("pattern_2", $i);
			$modifier = check_key("modifier", $i);
			$last_line = check_key("last_line", $i);
			$line_number_start = check_key("line_number_start", $i);
			$line_number_end = check_key("line_number_end", $i);
			$line_pattern_start = check_key("line_pattern_start", $i);
			$in_range_pattern = $array_commands[$i]{"in_range_pattern"};
			$array_commands[$i]{"in_range_pattern"} = substitute_command($line_number_command, $line_number, $line, $regex, $pattern_1, $pattern_2, $modifier, $last_line, $last_line_num, $line_number_start, $line_number_end, $line_pattern_start, $in_range_pattern);
			$array_commands[$i]{"in_range_pattern"} = $in_range_pattern;
		} else {
			$line_number_command = check_key("line_number_command", $i);
			$regex = check_key("regex", $i);
			$last_line = check_key("last_line", $i);
			$text = check_key("text", $i);
			$command = check_key("command", $i);
			subset2_commands($line_number_command, $line_number, $line, $regex, $last_line, $last_line_num, $text, $command);
		}
		if ($last == 3) {
			last;
		}
	}
	print "$output";
	$line_number ++;
	if ($last == 3) {
		last;
	}
	if (defined($next_line)) {
		$line = $next_line;
	} else {
		exit 0;
	}
}
