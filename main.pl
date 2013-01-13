use Encode;
use utf8; 
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
		#去掉所有换行和空白
		$content =~s/[\r\n]*|\s*|<br>|<br\/>//mg;
		#print $content;exit;
		#公司名
		@company= $content=~m/<th>CompanyName:<\/th><td>(.*?)<\/td>/g;
		#$company = @company[0];
		syswrite(HOME,$content);
		#联系人
		@contactor = $content=~m/<h5>(.*?)<\/h5>/g;
		#$contactor = @contactor[0];
		
		#联系人职位
		@position  =$content=~m/<\/h5><span>(.*?)<\/span>/g;
		
		#电话
		@telephone =$content=~m/<dt>Telephone:<\/dt><dd>(.*?)<\/dd>/g;
		
		#地址
		@address   =$content=~m/<dt>Address:<\/dt><dd>(.*?)<\/dd>/g;
		
		#邮编
		@zip       =$content=~m/<dt>Zip:<\/dt><dd>(.*?)<\/dd>/g;
		
		#国家
		@country   =$content=~m/<dt>Country\/Region:<\/dt><dd>(.*?)<\/dd>/g;
		
		#省份/州
		@state     =$content=~m/<dt>Province\/State:<\/dt><dd>(.*?)<\/dd>/g;
		
		#城市
		@city      = $content=~m/<dt>City:<\/dt><dd>(.*?)<\/dd>/g;
		
		#公司网站
		@site      = $content=~m/<th>Website:<\/th><td><a.*>(.*?)<\/a><\/td>/g;
		
		#阿里巴巴主页
		@alihome   =$content=~m/<th>Websiteonalibaba\.com:<\/th><td><ahref=\"(.*?)\"target=\'\_blank\'>.*?<\/td>/g;
		
		print 'company:'.@company[0]."\n";
		print 'contactor:'.@contactor[0]."\n";
		print 'position:'.@position[0]."\n";
		print 'telephone:'.@telephone[0]."\n";
		print 'address:'.@address[0]."\n";
		print 'zip:'.@zip[0]."\n";
		print 'country:'.@country[0]."\n";
		print 'state:'.@state[0]."\n";
		print 'city:'.@city[0]."\n";
		print 'site:'.@site[0]."\n";
		print 'alihome:'.@alihome[0]."\n";
		close(HOME);
		exit;
	}
}