
#module "mod_VBS_InputBox"
//�ϐ� = InputBox(prompt_str, title_str, default_str, xpos, xpos, helpfile_str , context)
//�p�����[�^�� http://msdn.microsoft.com/ja-jp/library/cc410238.aspx ���Q��
//�߂�l��int�^��0�Ȃ�L�����Z�����ꂽ�A������^�ϐ��Ȃ�OK���ꂽ
#define global InputBox(%1="",%2="",%3="",%4=$80000000,%5=$80000000,%6="",%7=0) _InputBox %1,%2,str(%3),%4,%5,%6,%7
#deffunc _InputBox str prompt_str,str title_str,str default_str,int xpos,int ypos,str helpfile_str ,int context,local f
	if vartype(objVBsc)=4 {
		newcom objVBsc, "ScriptControl"
		objVBsc("Language")="VBScript"
//����"AddCode"����Ηǂ��񂾂낤���ǁA��x�Ƀp�����[�^�ȗ��ɍ��킹��Function��o�^
		vbs = {"
			Function inBox0(m,t,d,x,y,h,c)
				inBox0 = InputBox(m,t,d,x,y,h,c)
			End Function
			Function inBox3(m,t,d,x,y,h,c)
				inBox3 = InputBox(m,t,d)
			End Function
			Function inBox2(m,t,d,x,y,h,c)
				inBox2 = InputBox(m,t,d,x,y)
			End Function
			Function inBox1(m,t,d,x,y,h,c)
				inBox1 = InputBox(m,t,d,,,h,c)
			End Function
		"}
		objVBsc->"AddCode" vbs
	}
	if helpfile_str="" {f | 2}
	if xpos=$80000000 or ypos=$80000000 {f | 1}//X,Y�ǂ��炩�ȗ����ꂽ�痼���ȗ��Ƃ��ď���
	comres res
	objVBsc->"Run" "inBox"+f ,prompt_str, title_str, default_str, xpos, ypos, helpfile_str, context
return res

#deffunc InputBox_end onexit
	if vartype(objVBsc)!=4{
		delcom objVBsc
	}
return
#global