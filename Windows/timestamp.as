//�Etime2ut(�N,��,��,��,��,�b)	�w�肵��������UNIX�^�C���X�^���v�ɕϊ�
//�Enow_ut	���݂�UNIX�^�C���X�^���v���擾
//�Eut2time v1,v2,v3,v4,v5,v6,UNIX�^�C�� v1�`v6�ɂ͕ϐ����w��BUNIX�^�C������N�E���E���E���E���E�b�����߂�

#module
#define global now_ut time2ut(gettime(0),gettime(1),gettime(3),gettime(4),gettime(5),gettime(6))

#defcfunc time2ut int _y,int _m,int d,int _h,int _mi,int _s
	y=_y
	m=_m-2
	if m<=0 : m+=12 : y--
	days=365*y + y/4 + y/400 - y/100 + 30*m+59*m/100 + d - 678912 - 40587
	//���w�肵�����̏C�������E�X�����t���[�Q���̌������狁�߁A
	//�����1970�N1��1���̏C�������E�X���ł���40587�������B
	h=_h-9	//�w�肵����������{��UTC�̎����ł���9�������B
	mi=_mi-0	//���{�Ɋւ��Č����΁A���̏C���͂Ȃ��B
	s=_s+0	//�[�b���l�����Ȃ��ꍇ�B�l������ꍇ�́��̃R�����g�A�E�g���O���B
	//s=_s+37
	return days*86400 + h*3600 + mi*60 + s

#deffunc ut2time var ry,var rm,var rd,var rh,var rmi,var rs,int _ut
	ut=_ut-0	//�[�b���l�����Ȃ��ꍇ�B�l������ꍇ�́��̃R�����g�A�E�g���O���B
	//ut=_ut-37
	add_h=9	//���{��UTC�Ƃ̎���
	add_m=0	//���{��UTC�Ƃ̎���(��)
	ut+=add_h*3600+add_m*60
	days=ut/86400 : a=ut\86400
	rh=a/3600 : a\=3600
	rmi=a/60 : rs=a\60
	//
	n=(days+40587)+678881	//(days+40587)�ŏC�������E�X���ɕϊ��B�ȉ��A�t���[�Q���̌����œ��t�����߂�B
	a=3+4*((4*(n+1)/146097+1)*3/4+n)
	b=(a\1461)/4*5+2
	ry=a/1461
	rm=b/153+3
	rd=(b\153)/5+1
	if rm>=13 : rm-=12 : ry++
	return

#global