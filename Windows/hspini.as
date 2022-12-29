// ini�t�@�C�����샂�W���[��
 
#ifndef IG_INI_FILE_MODULE_AS
#define IG_INI_FILE_MODULE_AS
 
// put �ŏ������݁Aget �œǂݍ���
//	(s: ������, d: ����, i: ����)
 
#module mod_ini
 
#uselib "kernel32.dll"
#func   WritePrivateProfileString "WritePrivateProfileStringA" sptr,sptr,sptr,sptr
#func   GetPrivateProfileString   "GetPrivateProfileStringA"   sptr,sptr,sptr,int,int,sptr
#cfunc  GetPrivateProfileInt      "GetPrivateProfileIntA"      sptr,sptr,int,sptr
 
#define ctype double_to_str@mod_ini(%1) strf("\"%%.16e\"", %1)
#define null 0
 
/*-----------------------------------------------*
.* ini: �t�@�C���p�X��ݒ肷��
.* 
.* @prm path: �t�@�C���p�X
.*   (��΃p�X�����΃p�X�Ɍ���B�t�@�C�����݂̂ł̓_���B)
.*-----------------------------------------------*/
#deffunc ini_setpath str _path
    _ini_path = _path
    
    // �ǂݏo���p�̃o�b�t�@���ŏ��l�Ŋm�ۂ���
    sdim _strbuf, 512
    return
    
/*-----------------------------------------------*
.* ini: �l����������
.*
.* @prm str section: �Z�N�V������
.* @prm str key:     �L�[��
.* @prm any value:   �l (������^�ɕϊ��\�Ȍ^�̂�)
.* 
.* @memo: ������^�̒l�� "" �Ŋ������`�ŏ������ނׂ��B
.*-----------------------------------------------*/
#define global ini_put(%1, %2, %3) ini_put_impl %1, %2, str(%3)
#deffunc ini_put_impl str sec, str key, str value
    WritePrivateProfileString sec, key, value, _ini_path
    return
    
// �}�N��
#define global ini_puts(%1, %2, %3) ini_put_impl %1, %2, "\"" + (%3) + "\""
#define global ini_putd(%1, %2, %3) ini_put_impl %1, %2, double_to_str@mod_ini(%3)
#define global ini_puti ini_put
 
/*-----------------------------------------------*
.* ini: �l��ǂݍ���
.*
.* ���O�̍Ō�� v �������͖̂��߂ŁA�������ɕϐ����Ƃ�B
.* �@�����łȂ����̂͊֐��ŁA�l�͊֐��̕Ԃ�l�ŕԂ��B
.* �w�肵���L�[�����݂��Ȃ��ꍇ�́Adefault �Ɏw�肳�ꂽ�l���Ԃ�B
.* 
.* @prm[var] dst:    (v) �󂯎��ϐ� (������^�łȂ���Ώ����������)
.* @prm str section: �Z�N�V������
.* @prm str key:     �L�[��
.* @prm str default: ����l ("")
.* @prm int size:    �ǂݍ��ޕ������̍ő� (��)
.*-----------------------------------------------*/
// �R�A����
// @ pSec, pKey �� ����, nullptr �Ő؂�ւ��ĕ����̑��������B
#deffunc ini_getv_something_impl var dst, int pSec, int pKey, int pDef, int size_,  local size
    if ( vartype(dst) != 2 ) { sdim dst }
    size = limit(size_, 64, 0xFFFF)            // �ŏ��ł� 64 �͊m�ۂ���
    
*LReTry:
    // �ǂݏo�����̃o�b�t�@���m��
    memexpand dst, size
    
    // �ǂݍ���
    GetPrivateProfileString pSec, pKey, pDef, varptr(dst), size, _ini_path
    
    // ������������Ȃ�����
    if ( (stat == size - 1 || stat == size - 2) && size_ <= 0 ) {
        size += size + 512        // �o�b�t�@���g�債�Ď擾������
        goto *LReTry
    }
    
    return
    
// ������
#define global ini_getsv(%1, %2, %3, %4 = "", %5 = 0) ini_getsv_ %1, %2, %3, %4, %5
#deffunc ini_getsv_ var dst, str sec_, str key_, str def_, int size_,  local sec, local key, local def
    sec = sec_
    key = key_
    def = def_
    ini_getv_something_impl dst, varptr(sec), varptr(key), varptr(def), size_
    return
    
#define global ctype ini_gets(%1, %2, %3 = "", %4 = 0) ini_gets_(%1, %2, %3, %4)
#defcfunc ini_gets_ str sec, str key, str def, int size_
    ini_getsv _strbuf, sec, key, def, size_
    return _strbuf
    
// ����
#define global ini_getdv(%1, %2, %3, %4 = 0) %1 = ini_getd(%2, %3, %4)
 
#define global ctype ini_getd(%1, %2, %3 = 0) ini_getd_(%1, %2, %3)
#defcfunc ini_getd_ str sec, str key, double def
    ini_getsv _strbuf, sec, key, double_to_str@mod_ini(def), 32        // 32[byte]������Ώ\��
    return double(_strbuf)
    
// ����
#define global ini_getiv(%1, %2, %3, %4 = 0) %1 = ini_geti(%2, %3, %4)
 
#defcfunc ini_geti str sec, str key, int def
;	ini_getsv _strbuf, sec, key, str(def), 32
;	return int(_strbuf)
    return GetPrivateProfileInt( sec, key, def, _ini_path )
    
/*-----------------------------------------------*
.* ini: �Z�N�V����, �L�[��񋓂���
.*
.* @prm array dst:     �󂯎��ϐ�(�z��)
.* @prm[str]  section: �Z�N�V���� (enumKey �̏ꍇ)
.* @prm int   size:    �ǂݍ��ޕ������̍ő� (��)
.*-----------------------------------------------*/
#deffunc ini_enumSection array dst_arr, int bufsize
    ini_getv_something_impl _strbuf, null, null, null, bufsize
    sdim dst_arr, stat
    SplitByNull dst_arr, _strbuf, stat
    return
    
#deffunc ini_enumKey array dst_arr, str section_, int bufsize,  local section
    section = section_
    ini_getv_something_impl _strbuf, varptr(section), null, null, bufsize
    sdim dst_arr, stat
    SplitByNull dst_arr, _strbuf, stat
    return
    
// cnv: '\0' ��؂蕶���� -> �z��
#deffunc SplitByNull@mod_ini array dst, var buf, int maxsize,  local idx
    idx = 0
    sdim dst
    repeat
        if ( idx >= maxsize ) { break }        // (2013/10/23) �R�����g�Q��
        getstr dst(cnt), buf, idx, , maxsize
    ;	logmes dst(cnt)
        idx += strsize + 1
    loop
    return
    
#ifdef _DEBUG
// ���ׂẴZ�N�V�����̃L�[��񋓂��f�o�b�O�o�͂���
 #deffunc ini_dbglog  local seclist, local sec, local keylist, local key, local stmp
    logmes "\n(ini_dbglog): @" + _ini_path
    ini_enumSection seclist            // �Z�N�V�������
    
    foreach seclist : sec = seclist(cnt)
        logmes strf("[%s]", sec)
        ini_enumKey keylist, sec    // �L�[���
        foreach keylist : key = keylist(cnt)
            ini_getsv stmp, sec, key, , 512
            logmes ("\t" + key + " = \"" + stmp + "\"")
        loop
    loop
    return
#else
 #define global ini_dbglog :
#endif
    
/*-----------------------------------------------*
.* ini: �Z�N�V����, �L�[���폜����
.*
.* @prm str  section: �Z�N�V����
.* @prm[str] key:     �L�[
.*-----------------------------------------------*/
#deffunc ini_removeSection str sec
    WritePrivateProfileString sec, null, null, _ini_path
    return
    
#deffunc ini_removeKey str sec, str key
    WritePrivateProfileString sec, key, null, _ini_path
    return
    
/*-----------------------------------------------*
.* ini: �L�[�����݂��邩�ۂ�
.*
.* @prm str section: �Z�N�V����
.* @prm str key:     �L�[
.*-----------------------------------------------*/
#defcfunc ini_exists str sec, str key
    return ( ini_geti(sec, key, 0) == 0 && ini_geti(sec, key, 1) == 1 )
    
#global
 
#endif