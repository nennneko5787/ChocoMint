// HSP3Dish�psplit��֖���

// �g�����́Asplit�Ɠ����ł�
// split A, "xyz", B �Ə����Ƃ���� dsplit A, "xyz", B �ɕς���Ɠ��삵�܂�

// �������A�Z�p�I�Ȗ��� split A, "xyz", B, C �̂悤�Ȏg�������ł��܂���

#ifndef dish_split
#module dish_split
#undef split
#deffunc split var in, str _delimiter, array out, local delimiter, local index, local oldindex, local temp
	sdim delimiter
	sdim out
	dim index
	dim oldindex
	dim temp
	delimiter = _delimiter
	repeat
		wait 0
		oldindex = index
		temp = instr(in, index, delimiter)
		if temp < 0 : index = strlen(in) + 1
		index += temp + strlen(delimiter)
		out(cnt) = strmid(in, oldindex, index - oldindex - strlen(delimiter))
		if index = strlen(in) + 1 + temp + strlen(delimiter) : index = cnt : break
	loop
	if index = 0 : out = in
	return index + 1
#global
#endif

