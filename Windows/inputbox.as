
#module "mod_VBS_InputBox"
//変数 = InputBox(prompt_str, title_str, default_str, xpos, xpos, helpfile_str , context)
//パラメータは http://msdn.microsoft.com/ja-jp/library/cc410238.aspx を参照
//戻り値がint型の0ならキャンセルされた、文字列型変数ならOKされた
#define global InputBox(%1="",%2="",%3="",%4=$80000000,%5=$80000000,%6="",%7=0) _InputBox %1,%2,str(%3),%4,%5,%6,%7
#deffunc _InputBox str prompt_str,str title_str,str default_str,int xpos,int ypos,str helpfile_str ,int context,local f
	if vartype(objVBsc)=4 {
		newcom objVBsc, "ScriptControl"
		objVBsc("Language")="VBScript"
//毎回"AddCode"すれば良いんだろうけど、一度にパラメータ省略に合わせたFunctionを登録
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
	if xpos=$80000000 or ypos=$80000000 {f | 1}//X,Yどちらか省略されたら両方省略として処理
	comres res
	objVBsc->"Run" "inBox"+f ,prompt_str, title_str, default_str, xpos, ypos, helpfile_str, context
return res

#deffunc InputBox_end onexit
	if vartype(objVBsc)!=4{
		delcom objVBsc
	}
return
#global