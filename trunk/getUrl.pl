use utf8; 
use LWP::RobotUA;
use LWP::Simple;

$start_page = 1;

$end_page = 17;

open COMID,">txt/url.txt";


my $url = 'http://www.alibaba.com/corporations/logistics/--US/';

$html = get($url.'1.html');

my @id = $html =~m/http:\/\/www\.alibaba\.com\/company\/[\d]+/g;

print @id;

foreach(my $i=$start_page;$i<=$end_page;$i++){
	#my $html = get($url.$i.'.html');
	#
	#print $html;
	#my @id = $html =~m/http:\/\/www\.alibaba\.com\/company\/[\d]+/g;
	#print @id ;
}