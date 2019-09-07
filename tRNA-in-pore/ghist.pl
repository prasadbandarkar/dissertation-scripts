use warnings;

print {STDOUT} "Enter the data file name:\n" ;

$IPFILENAME = <STDIN>;

chomp($IPFILENAME);

$min=`sort -g $IPFILENAME | head -1`;
chomp($min);
$max=`sort -g $IPFILENAME | tail -1`;
chomp($max);

print "Minimum value = ",$min,"\n";
print "Maximum value = ",$max,"\n";

$NoOfBins=$max-$min +1;

@freq = (0) x $NoOfBins;

open($ipfile,"$IPFILENAME");

while(<$ipfile>){
	$val = $_;
	chomp($val);
	$freq[$val-$min]+=1;
}

close($ipfile);

open my $Histfile,">$IPFILENAME.hist";

for($i=$min;$i<=$max;$i+=1){
	#print {$Histfile} $i," ",$freq[$i],"\n";
	print {$Histfile} $freq[$i-$min],"\n";	
}

close($Histfile);
