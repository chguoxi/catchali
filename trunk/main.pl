use LWP::RobotUA;
use utf8; 

#开始扫描的id号
my $beginid         = 251886;
#结束的id号
my $endid           = 2696863;
#每个文件存放多少条数据
my $per_num         = 100000;
my $current_num     = 0;
#爬行每个网址休眠的时间
my $delay_time = 1/60;
my $filename        = time();
#以当前时间戳生成文件名
open LOG,">txt/$filename.sql";
my $ua = LWP::RobotUA->new('Baiduspider/2.1', 'Baiduspider@baidu.com');
$ua->delay($delay_time);
#抓取过快被拒绝的时候自动休眠
$ua->use_sleep( true );