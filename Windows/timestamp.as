//・time2ut(年,月,日,時,分,秒)	指定した日時をUNIXタイムスタンプに変換
//・now_ut	現在のUNIXタイムスタンプを取得
//・ut2time v1,v2,v3,v4,v5,v6,UNIXタイム v1～v6には変数を指定。UNIXタイムから年・月・日・時・分・秒を求める

#module
#define global now_ut time2ut(gettime(0),gettime(1),gettime(3),gettime(4),gettime(5),gettime(6))

#defcfunc time2ut int _y,int _m,int d,int _h,int _mi,int _s
	y=_y
	m=_m-2
	if m<=0 : m+=12 : y--
	days=365*y + y/4 + y/400 - y/100 + 30*m+59*m/100 + d - 678912 - 40587
	//↑指定した日の修正ユリウス日をフリーゲルの公式から求め、
	//さらに1970年1月1日の修正ユリウス日である40587を引く。
	h=_h-9	//指定した時から日本とUTCの時差である9を引く。
	mi=_mi-0	//日本に関して言えば、分の修正はなし。
	s=_s+0	//閏秒を考慮しない場合。考慮する場合は↓のコメントアウトを外す。
	//s=_s+37
	return days*86400 + h*3600 + mi*60 + s

#deffunc ut2time var ry,var rm,var rd,var rh,var rmi,var rs,int _ut
	ut=_ut-0	//閏秒を考慮しない場合。考慮する場合は↓のコメントアウトを外す。
	//ut=_ut-37
	add_h=9	//日本とUTCとの時差
	add_m=0	//日本とUTCとの時差(分)
	ut+=add_h*3600+add_m*60
	days=ut/86400 : a=ut\86400
	rh=a/3600 : a\=3600
	rmi=a/60 : rs=a\60
	//
	n=(days+40587)+678881	//(days+40587)で修正ユリウス日に変換。以下、フリーゲルの公式で日付を求める。
	a=3+4*((4*(n+1)/146097+1)*3/4+n)
	b=(a\1461)/4*5+2
	ry=a/1461
	rm=b/153+3
	rd=(b\153)/5+1
	if rm>=13 : rm-=12 : ry++
	return

#global