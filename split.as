// HSP3Dish用split代替命令

// 使い方は、splitと同じです
// split A, "xyz", B と書くところを dsplit A, "xyz", B に変えると動作します

// ただし、技術的な問題で split A, "xyz", B, C のような使い方ができません

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

