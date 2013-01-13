use Encode;
use utf8; 
use LWP::Simple;

my $start_page = 1;

my $end_page = 17;

#保存主页的URL
open DATA,">data/data.txt";

foreach my $i($start_page..$end_page){
	my $url = 'http://www.alibaba.com/corporations/logistics/--US/';

	$html = get($url."$i.html");

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
		$content =~s/[\r\n]*|<br>|<br\s*\/>//mg;
		
		#公司名
		@company= $content=~m/<th>\s*Company Name:\s*<\/th>\s*<td>(.*?)<\/td>/g;
		#$company = @company[0];
		$content = encode_utf8($content);
		
		#联系人
		@contactor = $content=~m/<h5>\s*(.*?)\s*<\/h5>/g;
		#$contactor = @contactor[0];
		
		#联系人职位
		@position  =$content=~m/<\/h5>\s*<span>\s*(.*?)\s*<\/span>/g;
		
		#电话
		@telephone =$content=~m/<dt>\s*Telephone:\s*<\/dt>\s*<dd>\s*(.*?)\s*<\/dd>/g;
		
		#传真
		@fax       =$content=~m/<dt>\s*Fax:\s*<\/dt>\s*<dd>\s*(.*?)\s*<\/dd>/g;
		
		#地址
		@address   =$content=~m/<dt>\s*Address:\s*<\/dt>\s*<dd>\s*(.*?)\s*<\/dd>/g;
		
		#邮编
		@zip       =$content=~m/<dt>\s*Zip:\s*<\/dt>\s*<dd>\s*(.*?)\s*<\/dd>/g;
		
		#国家
		@country   =$content=~m/<dt>\s*Country\/Region:\s*<\/dt>\s*<dd>\s*(.*?)\s*<\/dd>/g;
		
		#省份/州
		@state     =$content=~m/<dt>\s*Province\/State:\s*<\/dt>\s*<dd>\s*(.*?)\s*<\/dd>/g;
		
		#城市
		@city      = $content=~m/<dt>\s*City:\s*<\/dt>\s*<dd>\s*(.*?)\s*<\/dd>/g;
		
		#公司网站
		@site      = $content=~m/<th>\s*Website:\s*<\/th>\s*<td>\s*<a.*?>(.*?)<\/a>\s*<\/td>/ig;
		
		#阿里巴巴主页
		@alihome   =$content=~m/<th>\s*Website on alibaba\.com:\s*<\/th>\s*<td>\s*<a href=\"(.*?)\"\s*target=\'\_blank\'\s*>\s*.*?\s*<\/td>/g;
		
		$sql = "INSERT INTO `company`.`logistic` (`company`, `contactor`, `position`, `telephone`, `fax`, `address`, `zip`, `country`, `state`, `city`, `site`, `alihome`) 
			VALUES ('@company[0]', '@contactor[0]', '@position[0]', '@telephone[0]', '@fax[0]', '@address[0]', '@zip[0]', '@country[0]', '@state[0]', '@city[0]', '@site[0]', '@alihome[0]');";
		print $sql."\n";
		syswrite(DATA,$sql);
	}
}