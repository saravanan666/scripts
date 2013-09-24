#!/usr/bin/perl
if ($#ARGV != 3 ) {
        print "usage: subtitle_adjuster.pl input_file output_file seconds_to_shift +/-\n";
        exit;
}
if ($ARGV[2] >= 60 ) {
        print "Script not designed for shifting more than 59 seconds. Try in two attempts if needed\n";
        exit;
}
$inputfile=$ARGV[0];
$outputfile=$ARGV[1];
$second=$ARGV[2];
$op=$ARGV[3];
open FILE, "<", "$inputfile" or die $!;
open FILE1, ">", "$outputfile" or die $!;
print "The operator is $op\n";
if($op eq "+") {
        print "Summing the seconds\n";
        while  ($line=<FILE>) {
                if ($line =~ /\-\-\>/)
                {
                        $line =~ s/\s//;
                        print $line;
                        ($time1,$time2)=split(/\-\-\>/, $line);
                        $ret_time1=calc_plus($time1,$second);
                        $ret_time2=calc_plus($time2,$second);
                        $line = "$ret_time1"." --> "."$ret_time2";
                }
                print FILE1 "$line";
        }
}
if($op eq "-") {
        print "Diffing the seconds\n";
        while  ($line=<FILE>) {
                if ($line =~ /\-\-\>/)
                {
                        $line =~ s/\s//;
                        print $line;
                        ($time1,$time2)=split(/\-\-\>/, $line);
                        $ret_time1=calc_minus($time1,$second);
                        $ret_time2=calc_minus($time2,$second);
                        $line = "$ret_time1"." --> "."$ret_time2";
                }
                print FILE1 "$line";
        }
}
sub calc_plus {
        ($time,$seconds)=@_;
        ($hr,$min,$sec)=split(/:/,"$time");
        ($sec1,$microsec)=split(/,/,$sec);
        $sec1=$sec1+$seconds;
        if($sec1>=60) {
                $sec1=$sec1-60;
                $min++;
                if($min==60) {
                        $hr++;
                        $min=0;
                }
        }
        $sec1=sprintf("%02d", $sec1);
        $min=sprintf("%02d", $min);
        $time_inter=join(':', $hr,$min,$sec1);
        $time_new=join(',', $time_inter,$microsec);
        return $time_new;
}
sub calc_minus {
        ($time,$seconds)=@_;
        ($hr,$min,$sec)=split(/:/,"$time");
        ($sec1,$microsec)=split(/,/,$sec);
        $sec1=$sec1-$seconds;
        if($sec1<0) {
                $sec1=60+$sec1;
                $min--;
                if($min==-1) {
                        $hr--;
                        $min=59;
                }
        }
        $sec1=sprintf("%02d", $sec1);
        $min=sprintf("%02d", $min);
        $time_inter=join(':', $hr,$min,$sec1);
        $time_new=join(',', $time_inter,$microsec);
        return $time_new;
}
close FILE;
