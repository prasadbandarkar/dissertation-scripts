#!/usr/bin/perl
use warnings;
use strict;
my $IPFILENAME=<STDIN>;
chomp($IPFILENAME);

##$FIRSTBIN = `head -n1 $IPFILENAME|awk '{print \$(1)}'`;
my $FIRSTBIN = `head -n1 "$IPFILENAME" |awk '{print \$1 }'`;
my $LASTBIN = `tail -n1 $IPFILENAME|awk '{print \$1 }'`;
if( $FIRSTBIN != -180 || $LASTBIN != 180 ){
	if( $FIRSTBIN != -180 ){
		open my $HEAD, ">", "tempheaddih";
 		for (my $i = -180; $i<$FIRSTBIN; $i++){
			print $HEAD $i," ","0.000\n";
		}
		close($HEAD);
		`mv $IPFILENAME tempdih`;
        	`cat tempheaddih tempdih > $IPFILENAME`;
		`rm tempheaddih tempdih`;
	}
	if( $LASTBIN != 180 ){
                open my $TAIL, ">", "temptaildih";
                for (my $i = $LASTBIN+1; $i<=180; $i++){
                        print $TAIL $i," ","0.000\n";
                }
		close($TAIL);
		`mv $IPFILENAME tempdih`;
                `cat tempdih temptaildih > $IPFILENAME`;
		`rm tempdih temptaildih`;
        }
}
