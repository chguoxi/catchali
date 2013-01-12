use utf8; 
use LWP::RobotUA;
use LWP::Simple;

my $start_page = 1;

my $end_page = 17;

#保存主页的URL
open HOME,">data/home.txt";

foreach my $i($start_page..$end_page){
	my $url = 'http://www.alibaba.com/corporations/logistics/--US/';

	$html = get($url.'1.html');

	my @id = $html =~m/http:\/\/www\.alibaba\.com\/company\/[\w]+\.html/g;

	foreach my $id(@id){
		#主页内容
		$home = get($id);
		#找到联系信息页网址
		@contact_url = $home =~m/http:\/\/www\.alibaba\.com\/member\/[\w]+\/contactinfo\.html/g;
		$curl = @contact_url[0];
		#获取公司联系信息页内容
		$content = get($curl);
		
		#公司名
		$company='';
		#联系人
		$contactor = '';
		#联系人职位
		$position='';
		#电话
		$telephone ='';
		#地址
		$address ='';
		#邮编
		$zip ='';
		#国家
		$country ='';
		#省份/州
		$state='';
		#城市
		$city = '';
		#公司网站
		$site = '';
		#阿里巴巴主页
		$alihome ='';
		
	}
}