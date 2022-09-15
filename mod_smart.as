;-----------------------------------------------------
; 
; HSP3用スマートフォンモジュール「mod_smart.as」
;
; Ver 3.6 (※注意：Ver 3.0以降から「hsp3dish.as」が必須となりました。事前に「hsp3dish.as」をインクルードしてください)
;
; By. しまくろねこ
;
; https://sites.google.com/site/simakuroneko/
; http://simakuroneko.bbs.fc2.com/
; simakuroneko@gmail.com
;
;-----------------------------------------------------
#ifndef __MOD_SMART__
#define __MOD_SMART__


;-----------------------------------------------------
#module mod_smart

#const FALSE						0
#const TRUE							1

#const double RAD_DOUBLE			1000000.0	; ラジアンを整数値にして返す倍率(smart_analog_res用)

;-------その他
;#const SARCH_TIME_MAX 				863999999	; 23時59分59秒のミリ秒
#const DEFAULT_TAP_INTERVAL 		400			; smart_tap命令のタップを認識する時間(この時間以内に指を押して、指を離す)
#const DEFAULT_TOUCH_INTERVAL 		1000		; smart_touch命令のタッチを認識する時間(この時間以上指を押し続ける)
#const DEFAULT_DRAG_INTERVAL        1000		; smart_drag命令のドラッグを認識する時間(この時間以上指を押し続ける)
#const DEFAULT_DOUBLE_TAP_INTERVAL 	700			; smart_dtap命令のダブルタップを認識する時間(この時間以内に1回目のタップから2回目のタップを行なう)
#const PARAM_1						0
#const PARAM_2						1
#const PARAM_3						2
#const PARAM_4						3
#const CP_MODE_0					0
#const CP_MODE_1					1
#const CP_MODE_2					2
#const CP_MODE_3					3
#const CP_MODE_4					4

;-------smart_mousearea
#const SMART_MOUSEAREA_RE_0			0			; 指定の領域内にマウスカーソルがない
#const SMART_MOUSEAREA_RE_1			1			; 指定の領域内にマウスカーソルがある

;-------smart_tap
#const SMART_TAP_RE_0				0			; タップされていない
#const SMART_TAP_RE_1				1			; タップされ始めた(画面に指をつけられた)
#const SMART_TAP_RE_2				2			; タップが終わった(画面から指を離された)

;-------smart_touch
#const SMART_TOUCH_RE_0				0			; タッチ(長押し)されていない
#const SMART_TOUCH_RE_1				1			; タッチ(長押し)された
#const SMART_TOUCH_RE_2				2			; 画面から指を離された

;-------smart_drag
#const SMART_DRAG_RE_0				0			; ドラッグされていない
#const SMART_DRAG_RE_1				1			; ドラッグされている(長押しされている)
#const SMART_DRAG_RE_2				2			; ドラッグが終了された(画面から指を離された)

;-------smart_dtap
#const SMART_DTAP_RE_0				0			; ダブルタップされていない
#const SMART_DTAP_RE_1				1			; １回目のタップがされた(画面に指をつけられた)
#const SMART_DTAP_RE_2				2			; １回目のタップが終わった(画面から指を離された)
#const SMART_DTAP_RE_3				3			; ２回目のタップ(ダブルタップ)がされた(画面に指をつけられた)

;-------smart_one
#const SMART_ONE_RE_0				0			; タップされていない(もしくは押し続けられている)
#const SMART_ONE_RE_1				1			; タップ(画面を押した)がされた

;-------smart_mtouch
#const SMART_MTOUCH_RE_0			0			; 指定の領域内をタッチしていない
#const SMART_MTOUCH_RE_1			1			; 指定の領域内をタッチしている

;-------smart_re_analog
#const SMART_ANALOG_RE_0			0			; 指定の領域内をタッチしていない
#const SMART_ANALOG_RE_1			1			; 指定の領域内をタッチしている
#const SMART_ANALOG_RE_2			2			; 指定の領域内をはみ出してタッチしている

;-------
#const SMART_GETKEY_REPEAT_MODE_0	0			; 一度だけ検出
#const SMART_GETKEY_REPEAT_MODE_1	1			; 連続で検出
#const SMART_GETKEY_REPEAT_MODE_2	2			; 連続で検出(離された瞬間も検出)

;-------
#define global ctype smart_mousearea(%1 = 0, %2 = 0, %3 = 0, %4 = 0) _smart_mousearea(%1, %2, %3, %4)
#define global smart_add(%1 = 0) _smart_add %1
#define global smart_max _smart_max(0)
#define global ctype smart_mode_get(%1 = 0) _smart_mode_get(%1)
#define global ctype smart_tap(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0, %6 = DEFAULT_TAP_INTERVAL@mod_smart, %7 = 0) _smart_tap(%1, %2, %3, %4, %5, %6, %7)
#define global ctype smart_touch(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0, %6 = DEFAULT_TOUCH_INTERVAL@mod_smart) _smart_touch(%1, %2, %3, %4, %5, %6)
#define global ctype smart_drag(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0, %6 = DEFAULT_DRAG_INTERVAL@mod_smart) _smart_drag(%1, %2, %3, %4, %5, %6)
#define global ctype smart_dtap(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0, %6 = DEFAULT_DOUBLE_TAP_INTERVAL@mod_smart, %7 = 0) _smart_dtap(%1, %2, %3, %4, %5, %6, %7)
#define global ctype smart_pinch(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0) _smart_pinch(%1, %2, %3, %4, %5)
#define global ctype smart_one(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0, %6 = 0) _smart_one(%1, %2, %3, %4, %5, %6)
#define global ctype smart_mtouch(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0) _smart_mtouch(%1, %2, %3, %4, %5)
#define global smart_keep(%1, %2, %3, %4, %5, %6, %7) _smart_keep %1, %2, %3, %4, %5, %6, %7
#define global smart_analog(%1 = 0, %2, %3 = 0, %4 = 0, %5 = 0) _smart_analog %1, %2, %3, %4, %5
#define global smart_reset(%1) _smart_reset %1
;#define GET_MILI_TIME (gettime(4) * 1000 * 60 * 60) + (gettime(5) * 1000 * 60) + (gettime(6) * 1000) + gettime(7)


;-----------------------------------------------------
; smart_init
;
; モジュールの初期処理
;-----------------------------------------------------
#deffunc smart_init

	; 以下の関数命令で共通して使用する配列
	;
	; smrat_tap(タップ)
	; smart_touch(タッチ)
	; smart_dtap(ダブルタップ)
	; smart_drag(ドラッグ)
	; smart_vswipe,smart_hswipe((スワイプ)
	; smart_pinch(ピンチイン/アウト)
	; smart_one(触れた瞬間を一度だけ検出)
	; smart_mtouch(マルチタッチ)
	; smart_keep
	; smart_analog
	dim tv,    1, 4			; 時間
	dim cp,    1, 4			; パラメータ
	dim moux,  1, 4			; マウスX座標
	dim mouy,  1, 4			; マウスY座標
	dim add_m, 1			;


	; smart_max用
	smart_add_max = 0


	; smart_analog用
	result_circle_x = 0
	result_circle_y = 0


	; 以下の関数命令で共通して使用する配列
	;
	; smrat_tap(タップ)
	; smart_one(触れた瞬間を一度だけ検出)
	; smart_mtouch(マルチタッチ)
	dim dkey, 256

	; smart_key_mode用
	plat_form = PLATFORM_WINDOWS
	getreq plat_form, SYSREQ_PLATFORM
	push_key_get_use_flg = FALSE
	get_mili = 0

	return


;-----------------------------------------------------
; smart_mousearea
;
; 指定の領域内にマウスカーソルがあるか取得
;
; x1 : 左上X座標
; y1 : 左上Y座標
; x2 : 右上X座標
; y2 : 右上Y座標
;
; 戻り値(0 = 指定の領域内にマウスカーソルがない)
;       (1 = 指定の領域内にマウスカーソルがある)
;
;=====================================================
; SAMPLE
;	if smart_mousearea(0, 0, 100, 200) = 1 : dialog "OK"
;-----------------------------------------------------
#defcfunc _smart_mousearea int x1, int y1, int x2, int y2

	re = SMART_MOUSEAREA_RE_0
	
	if mousex >= x1 {
		if mousex <= x2 {
			if mousey >= y1 {
				if mousey <= y2 {
					re = SMART_MOUSEAREA_RE_1
				}
			}
		}
	}
	
	return re


;-----------------------------------------------------
; smart_add
;
; タップ等の操作を取得するためのアクションを追加します。
;
;
; add_mode           : 追加するアクションモード(※例えば、0=タップ, 1=タッチ, 2=ドラッグ, 3=ダブルタップ, 4=縦スワイプ, 5=横スワイプ　など)
;                      (※smart_get関数で指定したアクション番号がどの操作のものかを調べるのに利用してください)
;                      (※アクションモードは省略可能です)
;
; 命令終了後、システム変数(stat)にアクション番号が入ります。
;
;=====================================================
; SAMPLE
;
;	smart_add 1 : act_number = stat
;
;-----------------------------------------------------
#deffunc smart_add int add_mode

	;----------------- tv
	d1 = length(tv)
	d2 = length2(tv)
	
	dim d_tv, d1, d2
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			d_tv(cnt_d1, cnt_d2) = tv(cnt_d1, cnt_d2)
		loop
	loop

	dim tv, d1 + 1, d2

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			tv(cnt_d1, cnt_d2) = d_tv(cnt_d1, cnt_d2)
		loop
	loop

	dim d_tv, 1, 1

	;----------------- cp
	d1 = length(cp)
	d2 = length2(cp)
	
	dim d_cp, d1, d2
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			d_cp(cnt_d1, cnt_d2) = cp(cnt_d1, cnt_d2)
		loop
	loop

	dim cp, d1 + 1, d2

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			cp(cnt_d1, cnt_d2) = d_cp(cnt_d1, cnt_d2)
		loop
	loop

	dim d_cp, 1, 1

	;----------------- moux
	d1 = length(moux)
	d2 = length2(moux)
	
	dim d_moux, d1, d2
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			d_moux(cnt_d1, cnt_d2) = moux(cnt_d1, cnt_d2)
		loop
	loop

	dim moux, d1 + 1, d2

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			moux(cnt_d1, cnt_d2) = d_moux(cnt_d1, cnt_d2)
		loop
	loop

	dim d_moux, 1, 1

	;----------------- mouy
	d1 = length(mouy)
	d2 = length2(mouy)
	
	dim d_mouy, d1, d2
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			d_mouy(cnt_d1, cnt_d2) = mouy(cnt_d1, cnt_d2)
		loop
	loop

	dim mouy, d1 + 1, d2

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			mouy(cnt_d1, cnt_d2) = d_mouy(cnt_d1, cnt_d2)
		loop
	loop

	dim d_mouy, 1, 1

	;----------------- add_m
	d1 = length(add_m)
	
	dim d_add_m, d1
	
	repeat d1
		cnt_d1 = cnt
		d_add_m(cnt_d1) = add_m(cnt_d1)
	loop

	dim add_m, d1 + 1

	repeat d1
		cnt_d1 = cnt
		add_m(cnt_d1) = d_add_m(cnt_d1)
	loop
	
	re = d1 - 1	
	
	add_m(re) = add_mode

	dim d_add_m, 1


	smart_add_max = re + 1

	return re


;-----------------------------------------------------
; smart_max
;
; smart_add命令により追加されたアクションの数を取得します。
;
; 戻り値
;   0 ～ = smart_add命令により追加されたアクションの数
;
;
;=====================================================
; SAMPLE
;
;   smart_add
;	a = smart_max
;
;   title "" + a
;
;-----------------------------------------------------
#defcfunc _smart_max int dummy

	return smart_add_max


;-----------------------------------------------------
; smart_mode_get
;
; 指定のアクション番号からアクションモードを取得します。
;
;
; act_num           : アクションモードを取得したいアクション番号
;
;
; 戻り値
;   0 ～ = アクションモード
;
;
;=====================================================
; SAMPLE
;
;   smart_add, 1
;   action_number = stat
;	action_mode = smart_mode_get(action_number)
;
;   title "" + action_mode
;
;-----------------------------------------------------
#defcfunc _smart_mode_get int act_num

	d1 = length(add_m) - 1

	if act_num >= d1 {
		re = -1
	} else {
		re = add_m(act_num)
	}

	return re


;-----------------------------------------------------
#deffunc smart_keymode int key_mode

	switch plat_form
	case PLATFORM_WINDOWS
		push_key_get_use_flg = key_mode	: swbreak	// smart_tap, smart_one, smart_mtouch関数でキーボードによる情報も取得する(1:取得する)
	case PLATFORM_IOS
	case PLATFORM_ANDROID
	default
		push_key_get_use_flg = FALSE	: swbreak	// smart_tap, smart_one, smart_mtouch関数でキーボードによる情報も取得する(0:取得しない)
	swend

	return


;-----------------------------------------------------
; smart_tap
;
; タップを取得
;
;
; act_num           : アクションを取得するアクション番号
; x1, y1, x2, y2    : タップを認識する画面座標
; tap_interval      : 指定の時間の間に画面を指で押して離すまでをタップと認識する(単位：ミリ秒)。省略時は、400ミリ秒とする。
;
;
; 戻り値
;   0 = タップされていない
;   1 = タップされ始めた(画面に指をつけられた)
;   2 = タップが終わった(画面から指を離された)
;
;
;=====================================================
; SAMPLE
;
;   smart_add
;	if smart_tap(stat, 0, 0, 319, 479, 400) = 2 : mes "TAP OK"
;
;-----------------------------------------------------
#defcfunc _smart_tap int act_num, int x1, int y1, int x2, int y2, int tap_interval, int push_key

	tap_key			= 0
	t_interval		= tap_interval
	push_key_flg	= FALSE

	if push_key > 0 && push_key_get_use_flg {
		func_dgetkey@mod_smart tap_key, push_key, SMART_GETKEY_REPEAT_MODE_1
		if tap_key > 0 {
			push_key_flg			= TRUE
			cp(act_num, PARAM_2)	= CP_MODE_1		; キーが押されたフラグ
		}
	}
	if push_key_flg == FALSE {
		dim touch_id, 1 : mtlist touch_id : tap_key = stat
	}

	if tap_key > 0 {
		dim touch, tap_key
		mtinfo touch, touch_id(0)
		i					= cp(act_num, PARAM_1)
		getreq get_mili, SYSREQ_TIMER
		tv(act_num, i)		= get_mili
		moux(act_num, i)	= touch(1)
		mouy(act_num, i)	= touch(2)

		if i == CP_MODE_0 {
			cp(act_num, PARAM_1) = CP_MODE_1
			re = SMART_TAP_RE_0
			if push_key_flg {
				re = SMART_TAP_RE_1
			} else {
				if moux(act_num, 0) >= x1 {
					if moux(act_num, 0) <= x2 {
						if mouy(act_num, 0) >= y1 {
							if mouy(act_num, 0) <= y2 {
								re = SMART_TAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_TAP_RE_0 {
				return SMART_TAP_RE_0
			} else {
				return SMART_TAP_RE_1
			}
		}

		if i == CP_MODE_1 {
			re = SMART_TAP_RE_0
			if push_key_flg {
				re = SMART_TAP_RE_1
			} else {
				if moux(act_num, 0) >= x1 {
					if moux(act_num, 0) <= x2 {
						if mouy(act_num, 0) >= y1 {
							if mouy(act_num, 0) <= y2 {
								re = SMART_TAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_TAP_RE_0 : return SMART_TAP_RE_0

			re = SMART_TAP_RE_0
			if push_key_flg {
				re = SMART_TAP_RE_1
			} else {
				if moux(act_num, 1) >= x1 {
					if moux(act_num, 1) <= x2 {
						if mouy(act_num, 1) >= y1 {
							if mouy(act_num, 1) <= y2 {
								re = SMART_TAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_TAP_RE_0 : return SMART_TAP_RE_0

			;if tv(act_num, 0) > tv(act_num, 1) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, 1)
			t = tv(act_num, 1) - tv(act_num, 0)
			if (t > t_interval) && (t_interval != -1) {
				return SMART_TAP_RE_0
			} else {
				return SMART_TAP_RE_1
			}
		}
	}

	if tap_key == 0 {
		i = cp(act_num, PARAM_1)
		if i == CP_MODE_1 {
			dim touch, 1
			mtinfo touch, touch_id(0)
			getreq get_mili, SYSREQ_TIMER
			tv(act_num, i)		= get_mili
			moux(act_num, i)	= touch(1)
			mouy(act_num, i)	= touch(2)

			;if tv(act_num, 0) > tv(act_num, 1) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, 1)
			t = tv(act_num, 1) - tv(act_num, 0)

			if (t <= t_interval) || (t_interval == -1) {

				cp(act_num, PARAM_1) = CP_MODE_2

				re = SMART_TAP_RE_0
				if cp(act_num, PARAM_2) == CP_MODE_1 {
					re = SMART_TAP_RE_1
				} else {
					if moux(act_num, 0) >= x1 {
						if moux(act_num, 0) <= x2 {
							if mouy(act_num, 0) >= y1 {
								if mouy(act_num, 0) <= y2 {
									re = SMART_TAP_RE_1
								}
							}
						}
					}
				}
				if re == SMART_TAP_RE_0 : return SMART_TAP_RE_0

				re = SMART_TAP_RE_0
				if cp(act_num, PARAM_2) == CP_MODE_1 {
					re = SMART_TAP_RE_1
				} else {
					if moux(act_num, 1) >= x1 {
						if moux(act_num, 1) <= x2 {
							if mouy(act_num, 1) >= y1 {
								if mouy(act_num, 1) <= y2 {
									re = SMART_TAP_RE_1
								}
							}
						}
					}
				}
				if re == SMART_TAP_RE_0 {
					return SMART_TAP_RE_0
				} else {
					return SMART_TAP_RE_2
				}
			}
		}
	}

	tv(act_num, 0)			= 0
	tv(act_num, 1)			= 0
	tv(act_num, 2)			= 0
	tv(act_num, 3)			= 0
	cp(act_num, PARAM_1)	= CP_MODE_0
	cp(act_num, PARAM_2)	= CP_MODE_0

	return SMART_TAP_RE_0


;-----------------------------------------------------
; smart_touch
;
; タッチ(長押し)を取得  (※タッチが認識された後、そのまま指が押されていてもタッチと認識されません。)
;
;
; act_num           : アクションを取得するアクション番号
; x1, y1, x2, y2    : タッチを認識する画面座標
; touch_interval    : タッチと認識するまでの時間(単位：ミリ秒)。省略時は、1000ミリ秒とする。
;
;
; 戻り値
;   0 = タッチ(長押し)されていない
;   1 = タッチ(長押し)された(画面に指をつけ続けられた)
;   2 = タッチ(長押し)が終わった(画面から指を離された)
;
;
;=====================================================
; SAMPLE
;
;   smart_add
;	if smart_touch(stat, 0, 0, 319, 479, 1000) = 1 : mes "TOUCH OK"
;
;-----------------------------------------------------
#defcfunc _smart_touch int act_num, int x1, int y1, int x2, int y2, int touch_interval

	t_interval = touch_interval
	dim touch_id, 1 : mtlist touch_id : touch_key = stat

	if touch_key > 0 {
		if cp(act_num, PARAM_1) == CP_MODE_2 : return SMART_TOUCH_RE_0
		dim touch, touch_key
		mtinfo touch, touch_id(0)
		i					= cp(act_num, PARAM_1)
		getreq get_mili, SYSREQ_TIMER
		tv(act_num, i)		= get_mili
		moux(act_num, i)	= touch(1)
		mouy(act_num, i)	= touch(2)

		if i == CP_MODE_0 {
			cp(act_num, PARAM_1) = CP_MODE_1
			return SMART_TOUCH_RE_0
		}
		
		if i == CP_MODE_1 {

			re = SMART_TOUCH_RE_0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = SMART_TOUCH_RE_1
						}
					}
				}
			}
			if re == SMART_TOUCH_RE_0 : return SMART_TOUCH_RE_0

			;if tv(act_num, 0) > tv(act_num, 1) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, 1)
			t = tv(act_num, 1) - tv(act_num, 0)
			if t < t_interval : return SMART_TOUCH_RE_0
			
			re = SMART_TOUCH_RE_0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = SMART_TOUCH_RE_1
						}
					}
				}
			}
			if re == SMART_TOUCH_RE_0 : return SMART_TOUCH_RE_0
	
			re = SMART_TOUCH_RE_0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = SMART_TOUCH_RE_1
						}
					}
				}
			}
			if re == SMART_TOUCH_RE_0 : return SMART_TOUCH_RE_0

			tv(act_num, 0)			= 0
			tv(act_num, 1)			= 0
			cp(act_num, PARAM_1)	= CP_MODE_2
			return SMART_TOUCH_RE_1

		}
	}

	if touch_key == 0 {
		i = cp(act_num, PARAM_1)
		if i == CP_MODE_2 {

			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							tv(act_num, 0)			= 0
							tv(act_num, 1)			= 0
							cp(act_num, PARAM_1)	= CP_MODE_3
							return SMART_TOUCH_RE_2
						}
					}
				}
			}

		}			
	}

	tv(act_num, 0)			= 0
	tv(act_num, 1)			= 0
	tv(act_num, 2)			= 0
	tv(act_num, 3)			= 0
	cp(act_num, PARAM_1)	= CP_MODE_0

	return SMART_TOUCH_RE_0


;-----------------------------------------------------
; smart_drag
;
; ドラッグを取得
;
;
; act_num           : アクションを取得するアクション番号
; x1, y1, x2, y2    : ドラッグを認識する画面座標領域
; drag_interval     : ドラッグと認識するまでの時間(単位：ミリ秒)。省略時は、1000ミリ秒とする。
;
;
; 戻り値
;   0 = ドラッグされていない
;   1 = ドラッグされている(画面に指をつけ続けられた)
;   2 = ドラッグが終了された(画面から指を離された)
;
;
;=====================================================
; SAMPLE
;
;   smart_add : act_num = stat
;
;   repeat
;        redraw 0
;
;        color 255, 0, 0
;        boxf x, y, x + 200, y + 200
;
;        drag = smart_drag(act_num, x, y, x + 170, y + 50, 1000)
;
;        if drag = 0 {
;             start_x = mousex - x
;             start_y = mousey - y
;	     }
;        if drag = 1 {
;             x = mousex - start_x
;             y = mousey - start_y
;        }
;        if drag = 2 {
;             mes "DRAG FINISH"
;             wait 1000
;        }
;
;        redraw 1
;        wait 1
;   loop
;
;-----------------------------------------------------
#defcfunc _smart_drag int act_num, int x1, int y1, int x2, int y2, int drag_interval

	t_interval = drag_interval
	dim touch_id, 1 : mtlist touch_id : drag_key = stat

	if drag_key > 0 {
		dim touch, drag_key
		mtinfo touch, touch_id(0)
		i					= cp(act_num, PARAM_1)
		getreq get_mili, SYSREQ_TIMER
		tv(act_num, i)		= get_mili
		moux(act_num, i)	= touch(1)
		mouy(act_num, i)	= touch(2)

		if i == CP_MODE_0 {
			cp(act_num, PARAM_1) = CP_MODE_1
			return SMART_DRAG_RE_0
		}
		
		if i == CP_MODE_1 {

			re = SMART_DRAG_RE_0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = SMART_DRAG_RE_1
						}
					}
				}
			}
			if re == SMART_DRAG_RE_0 : return SMART_DRAG_RE_0

			;if tv(act_num, 0) > tv(act_num, 1) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, 1)
			t = tv(act_num, 1) - tv(act_num, 0)
			if t < t_interval : return SMART_DRAG_RE_0

			moux(act_num, 0) = moux(act_num, 1)
			mouy(act_num, 0) = mouy(act_num, 1)
			
			re = SMART_DRAG_RE_0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = SMART_DRAG_RE_1
						}
					}
				}
			}
			if re == SMART_DRAG_RE_0 : return SMART_DRAG_RE_0
	
			re = SMART_DRAG_RE_0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = SMART_DRAG_RE_1
						}
					}
				}
			}
			if re == SMART_DRAG_RE_0 {
				return SMART_DRAG_RE_0
			} else {
				return SMART_DRAG_RE_1
			}
		}
	}

	if drag_key == 0 {
		i = cp(act_num, PARAM_1)
		if i == CP_MODE_1 {
			dim touch, 1
			mtinfo touch, touch_id(0)
			getreq get_mili, SYSREQ_TIMER
			tv(act_num, i)		= get_mili
			moux(act_num, i)	= touch(1)
			mouy(act_num, i)	= touch(2)

			;if tv(act_num, 0) > tv(act_num, 1) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, 1)
			t = tv(act_num, 1) - tv(act_num, 0)

			if t >= t_interval {
				
				cp(act_num, PARAM_1) = CP_MODE_2
	
				re = SMART_DRAG_RE_0
				if moux(act_num, 0) >= x1 {
					if moux(act_num, 0) <= x2 {
						if mouy(act_num, 0) >= y1 {
							if mouy(act_num, 0) <= y2 {
								re = SMART_DRAG_RE_1
							}
						}
					}
				}
				if re == SMART_DRAG_RE_0 : return SMART_DRAG_RE_0
	
				re = SMART_DRAG_RE_0
				if moux(act_num, 1) >= x1 {
					if moux(act_num, 1) <= x2 {
						if mouy(act_num, 1) >= y1 {
							if mouy(act_num, 1) <= y2 {
								re = SMART_DRAG_RE_1
							}
						}
					}
				}
				if re == SMART_DRAG_RE_0 {
					return SMART_DRAG_RE_0
				} else {
					return SMART_DRAG_RE_2
				}
			}
		}
	}

	tv(act_num, 0)			= 0
	tv(act_num, 1)			= 0
	tv(act_num, 2)			= 0
	tv(act_num, 3)			= 0
	cp(act_num, PARAM_1)    = CP_MODE_0

	return SMART_DRAG_RE_0


;-----------------------------------------------------
; smart_dtap
;
; ダブルタップを取得
;
;
; act_num             : アクションを取得するアクション番号
; x1, y1, x2, y2      : ダブルタップを認識する画面座標
; double_tap_interval : 指定の時間の間に画面を指で押して離して押すまでをダブルタップと認識する(単位：ミリ秒)。省略時は、700ミリ秒とする。
;
;
; 戻り値
;   0 = ダブルタップされていない
;   1 = １回目のタップがされた(画面に指をつけられた)
;   2 = １回目のタップが終わった(画面から指を離された)
;   3 = ２回目のタップ(ダブルタップ)がされた(画面に指をつけられた)
;
;
;=====================================================
; SAMPLE
;
;   smart_add
;   if smart_dtap(stat, 0, 0, 319, 479, 700) = 3 : mes "DOUBLE TAP OK"
;
;-----------------------------------------------------
#defcfunc _smart_dtap int act_num, int x1, int y1, int x2, int y2, int double_tap_interval, int push_key

	double_tap_key	= 0
	t_interval		= double_tap_interval
	push_key_flg	= FALSE

	if push_key > 0 && push_key_get_use_flg {
		func_dgetkey@mod_smart double_tap_key, push_key, SMART_GETKEY_REPEAT_MODE_1
		if double_tap_key > 0 {
			push_key_flg			= TRUE
			push_key_d_flg			= TRUE
			cp(act_num, PARAM_2)	= CP_MODE_1		; キーが押されたフラグ
		}
	}
	if push_key_flg == FALSE {
		dim touch_id, 1 : mtlist touch_id : double_tap_key = stat
	}

	if double_tap_key > 0 {
		dim touch, double_tap_key
		mtinfo touch, touch_id(0)
		i					= cp(act_num, PARAM_1)
		getreq get_mili, SYSREQ_TIMER
		tv(act_num, i)		= get_mili
		moux(act_num, i)	= touch(1)
		mouy(act_num, i)	= touch(2)
		
		if i == CP_MODE_0 {
			cp(act_num, PARAM_1) = CP_MODE_1
			re = SMART_DTAP_RE_0

			if push_key_flg {
				re = SMART_DTAP_RE_1
			} else {
				if moux(act_num, 0) >= x1 {
					if moux(act_num, 0) <= x2 {
						if mouy(act_num, 0) >= y1 {
							if mouy(act_num, 0) <= y2 {
								re = SMART_DTAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_DTAP_RE_0 {
				push_key_d_flg = FALSE
				return SMART_DTAP_RE_0
			} else {
				return SMART_DTAP_RE_1
			}
		}
		
		if i == CP_MODE_1 {
			re = SMART_DTAP_RE_0
			if push_key_flg {
				re = SMART_DTAP_RE_1
			} else {
				if moux(act_num, 0) >= x1 {
					if moux(act_num, 0) <= x2 {
						if mouy(act_num, 0) >= y1 {
							if mouy(act_num, 0) <= y2 {
								re = SMART_DTAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_DTAP_RE_0 {
				push_key_d_flg = FALSE
				return SMART_DTAP_RE_0
			}

			re = SMART_DTAP_RE_0
			if push_key_flg {
				re = SMART_DTAP_RE_1
			} else {
				if moux(act_num, 1) >= x1 {
					if moux(act_num, 1) <= x2 {
						if mouy(act_num, 1) >= y1 {
							if mouy(act_num, 1) <= y2 {
								re = SMART_DTAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_DTAP_RE_0 {
				push_key_d_flg = FALSE
				return SMART_DTAP_RE_0
			}

			;if tv(act_num, 0) > tv(act_num, 1) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, 1)
			t = tv(act_num, 1) - tv(act_num, 0)
			if t > t_interval {
				push_key_d_flg = FALSE
				return SMART_DTAP_RE_0
			} else {
				return SMART_DTAP_RE_1
			}
		}

		if i == CP_MODE_2 {
			re = SMART_DTAP_RE_0
			if push_key_flg {
				re = SMART_DTAP_RE_1
			} else {
				if moux(act_num, 0) >= x1 {
					if moux(act_num, 0) <= x2 {
						if mouy(act_num, 0) >= y1 {
							if mouy(act_num, 0) <= y2 {
								re = SMART_DTAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_DTAP_RE_0 {
				push_key_d_flg = FALSE
				return SMART_DTAP_RE_0
			}

			re = SMART_DTAP_RE_0
			if push_key_flg {
				re = SMART_DTAP_RE_1
			} else {
				if moux(act_num, 1) >= x1 {
					if moux(act_num, 1) <= x2 {
						if mouy(act_num, 1) >= y1 {
							if mouy(act_num, 1) <= y2 {
								re = SMART_DTAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_DTAP_RE_0 {
				push_key_d_flg = FALSE
				return SMART_DTAP_RE_0
			}
	
			re = SMART_DTAP_RE_0
			if push_key_flg {
				re = SMART_DTAP_RE_1
			} else {
				if moux(act_num, 2) >= x1 {
					if moux(act_num, 2) <= x2 {
						if mouy(act_num, 2) >= y1 {
							if mouy(act_num, 2) <= y2 {
								re = SMART_DTAP_RE_1
							}
						}
					}
				}
			}
			if re == SMART_DTAP_RE_0 {
				push_key_d_flg = FALSE
				return SMART_DTAP_RE_0
			}

			;if tv(act_num, 0) > tv(act_num, 2) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, 2)
			t = tv(act_num, 2) - tv(act_num, 0)
			if t > t_interval : return SMART_DTAP_RE_0
			cp(act_num, PARAM_1) = CP_MODE_3
			return SMART_DTAP_RE_3
		}
	
		if i == CP_MODE_3 : return SMART_DTAP_RE_0
		
	}

	if double_tap_key == 0 {
		i = cp(act_num, PARAM_1)
		if (i == CP_MODE_1) || (i == CP_MODE_2) {
			dim touch, 1
			mtinfo touch, touch_id(0)
			getreq get_mili, SYSREQ_TIMER
			tv(act_num, i)		= get_mili
			moux(act_num, i)	= touch(1)
			mouy(act_num, i)	= touch(2)

			;if tv(act_num, 0) > tv(act_num, i) : tv(act_num, 0) = SARCH_TIME_MAX - tv(act_num, 0) + tv(act_num, i)
			t = tv(act_num, i) - tv(act_num, 0)

			if t <= t_interval {

				cp(act_num, PARAM_1) = CP_MODE_2
	
				re = SMART_DTAP_RE_0
				if push_key_d_flg {
					re = SMART_DTAP_RE_1
				} else {
					if moux(act_num, 0) >= x1 {
						if moux(act_num, 0) <= x2 {
							if mouy(act_num, 0) >= y1 {
								if mouy(act_num, 0) <= y2 {
									re = SMART_DTAP_RE_1
								}
							}
						}
					}
				}
				
				if re == SMART_DTAP_RE_0 {
					cp(act_num, PARAM_1) = CP_MODE_0
					return SMART_DTAP_RE_0
				}

				re = SMART_DTAP_RE_0
				if push_key_d_flg {
					re = SMART_DTAP_RE_1
				} else {
					if moux(act_num, i) >= x1 {
						if moux(act_num, i) <= x2 {
							if mouy(act_num, i) >= y1 {
								if mouy(act_num, i) <= y2 {
									re = SMART_DTAP_RE_1
								}
							}
						}
					}
				}
				if re == SMART_DTAP_RE_0 {
					return SMART_DTAP_RE_0
				} else {
					return SMART_DTAP_RE_2
				}
			}
		}
	}
	
	tv(act_num, 0)			= 0
	tv(act_num, 1)			= 0
	tv(act_num, 2)			= 0
	tv(act_num, 3)			= 0	
	cp(act_num, PARAM_1)	= CP_MODE_0

	return SMART_DTAP_RE_0


;-----------------------------------------------------
; smart_one
;
; タップされた(画面を押した)瞬間を一度だけ取得。(※離したときは含まれず)
;
; act_num           ; アクションを取得するアクション番号標
; x1, y1, x2, y2    : タップを認識する画面座標
;
; 戻り値
;    0 = タップされていない(もしくは押し続けられている)
;    1 = タップ(画面を押した)がされた
;
;=====================================================
; SAMPLE
;
;   smart_add : act = stat
;
;*main
;
;	if smart_one(act, 0, 0, 639, 479) = 1 {
;		c++
;		mes "MOUSE LEFT BUTTON ONLY ONE = " + c
;	}
;	wait 1
;	goto *main
;
;-----------------------------------------------------
#defcfunc _smart_one int act_num, int x1, int y1, int x2, int y2, int push_key

	one_key					= 0
	re						= SMART_ONE_RE_0
	cp(act_num, PARAM_1)	= FALSE
	moux(act_num, 0)		= 0
	mouy(act_num, 0)		= 0
	touch_id				= 0
	push_key_flg			= FALSE

	if push_key > 0 && push_key_get_use_flg {
		func_dgetkey@mod_smart one_key, push_key, SMART_GETKEY_REPEAT_MODE_0
		if one_key > 0 : push_key_flg = TRUE
	}
	if push_key_flg == FALSE {
		mtlist touch_id : one_key = stat
	}

	if one_key == 0 {
		cp(act_num, PARAM_2) = FALSE
		return SMART_ONE_RE_0
	}

	if one_key > 0 {
		if push_key_flg {
			re = SMART_ONE_RE_1
		} else {
			dim touch, one_key
			repeat one_key
				mtinfo touch, touch_id(cnt)
				moux(act_num, 0) = touch(1)
				mouy(act_num, 0) = touch(2)
				if moux(act_num, 0) >= x1 {
					if moux(act_num, 0) <= x2 {
						if mouy(act_num, 0) >= y1 {
							if mouy(act_num, 0) <= y2 {
								if cp(act_num, PARAM_2) == FALSE : re = SMART_ONE_RE_1
								cp(act_num, PARAM_2) = TRUE
								cp(act_num, PARAM_1) = TRUE
								break
							}
						}
					}
				}
			loop
	
			if cp(act_num, PARAM_1) == FALSE {
				cp(act_num, PARAM_2) = FALSE
				re = SMART_ONE_RE_0
			}
		}
	}

	return re


;-----------------------------------------------------
; smart_pinch
;
; ピンチアウト/インを取得
;
; act_num           ; アクションを取得するアクション番号標
; x1, y1, x2, y2    : ピンチアウト/インを認識する画面座標
;
; 戻り値
;    -1(以下) = ピンチインされている
;    0        = スクリーンをマルチタッチされていない
;    1(以上)  = ピンチアウトされている
;
;=====================================================
; SAMPLE
;
;   smart_add : act_num = stat
;
;*main
;
;   redraw 0
;
;   i = smart_pinch(act_num, 0, 0, 479, 319)
;   pos 0, 0
;   if i = 0   : mes "NOT MULTI TOUCH"
;   if i >= 1  : mes "PINCH OUT"
;   if i <= -1 : mes "PINCH IN"
;
;   redraw 1
;	wait 1
;
;	goto *main
;
;-----------------------------------------------------
#defcfunc _smart_pinch int act_num, int x1, int y1, int x2, int y2

	re	= 0
	i	= 0
	dim touch_id, 1 : mtlist touch_id : tap_key = stat

	if tap_key > 1 {

		i = cp(act_num, PARAM_1)

		dim touch, tap_key
		repeat tap_key
			mtinfo touch, touch_id(cnt)

			if touch(1) >= x1 {
				if touch(1) <= x2 {
					if touch(2) >= y1 {
						if touch(2) <= y2 {
							c =  cp(act_num, PARAM_1) * 2
							switch cp(act_num, PARAM_2)
							case CP_MODE_0
								moux(act_num, 0 + c) = touch(1)
								mouy(act_num, 0 + c) = touch(2)
								cp(act_num, PARAM_2) = CP_MODE_1
								swbreak
							case CP_MODE_1
								moux(act_num, 1 + c) = touch(1)
								mouy(act_num, 1 + c) = touch(2)
								cp(act_num, PARAM_2) = CP_MODE_2
								swbreak
							swend
							if cp(act_num, PARAM_2) == CP_MODE_2 : break
						}
					}
				}
			}


		loop

		if cp(act_num, PARAM_2) == CP_MODE_2 {

			cp(act_num, PARAM_2) = CP_MODE_0

			if i == CP_MODE_0 {
				first_point_x			= abs(moux(act_num, 0) - moux(act_num, 1))
				first_point_y			= abs(mouy(act_num, 0) - mouy(act_num, 1))
				first_distance			= (first_point_x * first_point_x) + (first_point_y * first_point_y)
				cp(act_num, PARAM_3)	= int(sqrt(first_distance))
				cp(act_num, PARAM_1)	= CP_MODE_1
				return 0
			}
			
			if i == CP_MODE_1 {
				touch_point_x			= abs(moux(act_num, 2) - moux(act_num, 3))
				touch_point_y			= abs(mouy(act_num, 2) - mouy(act_num, 3))
				touch_distance			= (touch_point_x * touch_point_x) + (touch_point_y * touch_point_y)
				cp(act_num, PARAM_4)	= int(sqrt(touch_distance))
				re						= cp(act_num, PARAM_4) - cp(act_num, PARAM_3)
				return re
			}

		}
	}

	cp(act_num, PARAM_1) = CP_MODE_0
	cp(act_num, PARAM_2) = CP_MODE_0

	return 0


;-----------------------------------------------------
; smart_mtouch
;
; 指定の領域内をタッチ(ここで言うタッチとは画面に触れている)しているかを取得
; マルチタッチに対応
;
; x1 : 左上X座標
; y1 : 左上Y座標
; x2 : 右上X座標
; y2 : 右上Y座標
;
; 戻り値(0 = 指定の領域内をタッチしていない)
;       (1 = 指定の領域内をタッチしている)
;
;=====================================================
; SAMPLE
;
;	if smart_mtouch(0, 0, 100, 200) = 1 : dialog "OK"
;
;-----------------------------------------------------
#defcfunc _smart_mtouch int x1, int y1, int x2, int y2, int push_key

	tap_key			= 0
	re				= SMART_MTOUCH_RE_0
	mx				= 0
	my				= 0
	touch_id		= 0
	push_key_flg	= FALSE

	if push_key > 0 && push_key_get_use_flg {
		func_dgetkey@mod_smart tap_key, push_key, SMART_GETKEY_REPEAT_MODE_1
		if tap_key > 0 : push_key_flg = TRUE
	}
	if push_key_flg == FALSE {
		mtlist touch_id : tap_key = stat
	}

	if tap_key > 0 {
		if push_key_flg {
			re = SMART_MTOUCH_RE_1
		} else {
			dim touch, tap_key
			repeat tap_key
				mtinfo touch, touch_id(cnt)
				mx = touch(1)
				my = touch(2)
				if mx >= x1 {
					if mx <= x2 {
						if my >= y1 {
							if my <= y2 {
								re = SMART_MTOUCH_RE_1
								break
							}
						}
					}
				}
			loop
		}
	}

	return re


;-----------------------------------------------------
; smart_keep
;
; タッチしているXY座標を引数(パラメーター)に足す
;
; act_num           ; アクションを取得するアクション番号標
; x1, y1, x2, y2    : タップを認識する画面座標
; tmx               : タッチしているX座標を保持するX座標の数値変数
; tmy               : タッチしているY座標を保持するY座標の数値変数
;
; 命令終了後、システム変数(stat)にマルチタッチされた値が入ります。
;
;=====================================================
; SAMPLE
;	
;#cmpopt varinit 1			;未初期化変数のチェック
;
;#include "hsp3dish.as"		;HSP3Dish
;#include "mod_smart.as"		;当モジュール
;
;#const WINDOW_WIDTH		480
;#const WINDOW_HEIGHT	320
;
;	smart_init	;[mod_smart.as]モジュールの初期処理
;	smart_add
;	smart_add
;
;	mes_cnt = 2
;
;	dim x, mes_cnt
;	dim y, mes_cnt
;	x(0) = 100 : y(0) = 100
;	x(1) = 200 : y(1) = 100
;
;	dim x1, 2
;	dim y1, 2
;	dim x2, 2
;	dim y2, 2
;	x1(0) = 100 : y1(0) = 100 : x2(0) = 200 : y2(0) = 200
;	x1(1) = 250 : y1(1) = 100 : x2(1) = 350 : y2(1) = 200
;
;*main
;
;	redraw 0
;	color 0, 0, 150 : boxf
;	color 0, 0, 255 : boxf x1(0), y1(0), x2(0), y2(0)
;	color 0, 0, 255 : boxf x1(1), y1(1), x2(1), y2(1)
;	color 255, 255, 255
;
;	repeat mes_cnt
;		smart_keep cnt, x1(cnt), y1(cnt), x2(cnt), y2(cnt), x(cnt), y(cnt)
;	loop
;
;	mt_cnt = stat
;	
;	pos 0, 0
;	mes str(mt_cnt)
;	
;	repeat mes_cnt
;		if x(cnt) < 0 : x(cnt) = 0
;		if x(cnt) > (WINDOW_WIDTH - 20)  : x(cnt) = WINDOW_WIDTH - 20
;		if y(cnt) < 0 : y(cnt) = 0
;		if y(cnt) > (WINDOW_HEIGHT - 20) : y(cnt) = WINDOW_HEIGHT - 20
;		pos x(cnt), y(cnt)
;		mes str(cnt + 1)
;	loop
;	
;	redraw 1
;	wait 1
;	goto *main
;
;-----------------------------------------------------
#deffunc _smart_keep int act_num, int x1, int y1, int x2, int y2, var tmx, var tmy

	touch_id = 0

	mtlist touch_id : tap_key = stat

	if tap_key > 0 {

		dim touch, tap_key

		repeat tap_key
			tid = touch_id(cnt)
			mtinfo touch, tid
			
			tap_x = touch(1)
			tap_y = touch(2)

			cp(act_num, PARAM_1) = FALSE

			if tap_x >= x1 {
				if tap_x <= x2 {
					if tap_y >= y1 {
						if tap_y <= y2 {
							cp(act_num, PARAM_1) = TRUE
						}
					}
				}
			}

			if cp(act_num, PARAM_1) == TRUE {
				switch cp(act_num, PARAM_2)
				case FALSE
					cp(act_num, PARAM_2)	= TRUE
					moux(act_num, 0)		= 0
					mouy(act_num, 0)		= 0
					swbreak
				case TRUE
					tmx += tap_x - moux(act_num, 0)
					tmy += tap_y - mouy(act_num, 0)
					swbreak
				swend
				moux(act_num, 0) = tap_x
				mouy(act_num, 0) = tap_y
				break
			} else {
				if cnt == (tap_key - 1) : cp(act_num, PARAM_2) = FALSE
			}
		loop
	} else {
		cp(act_num, PARAM_2) = FALSE
	}

	return tap_key


;-----------------------------------------------------
; smart_analog
;
; 仮想アナログスティック操作を制御
;
; act_num						: アクションを取得するアクション番号
; result_value					: 取得する実数型配列変数
; circle_x, circle_y, x2, y2	: 円の中心点となる画面座標
; circle_half_width				: 中心点からの半径
;
; 命令終了後、smart_analog_resに操作された値が入ります。
;
;=====================================================
;
;-----------------------------------------------------
#deffunc _smart_analog int act_num, array result_value, int circle_x, int circle_y, int circle_half_width

	result_circle_x = circle_x
	result_circle_y = circle_y

	touch_id = 0 : mtlist touch_id : tap_key = stat

	if tap_key > 0 {
		repeat_break = FALSE
		dim touch, tap_key
		repeat tap_key
			mtinfo touch, touch_id(cnt)
			func_circle_point_check@mod_smart act_num, circle_x, circle_y, circle_half_width, touch(1), touch(2), touch(3) + 10, repeat_break
			if repeat_break == TRUE : break
		loop
		;2015/10/14.add.
		if repeat_break == FALSE : cp(act_num, PARAM_4) = -1
	} else {
		cp(act_num, PARAM_1)	= SMART_ANALOG_RE_0
		moux(act_num, 0)		= circle_x
		mouy(act_num, 0)		= circle_y
		touch_distance_in		= 0
		moux(act_num, 1)		= circle_x
		mouy(act_num, 1)		= circle_y
		touch_distance_all		= 0
		cp(act_num, PARAM_2)	= 0
		cp(act_num, PARAM_3)	= 0
		cp(act_num, PARAM_4)	= 0
	}

	func_analog_res@mod_smart act_num, result_value

	return


;-----------------------------------------------------
#deffunc local func_circle_point_check int act_num, int circle_x, int circle_y, int circle_half_width, int point_x, int point_y, int id, var rep_break
; cp(act_num, PARAM_1) = タッチフラグ(0:タッチしてない, 1:領域内でタッチ)
; cp(act_num, PARAM_2) = 角度(360)
; cp(act_num, PARAM_3) = ラジアン
; cp(act_num, PARAM_4) = マルチタッチの識別ID

	rep_break	= FALSE
	xy			= (circle_x - point_x) * (circle_x - point_x)
	xy		   += (circle_y - point_y) * (circle_y - point_y)
	half		= circle_half_width * circle_half_width
	rad			= atan(point_y - circle_y, point_x - circle_x)

	if xy < half {
		cp(act_num, PARAM_1)	= SMART_ANALOG_RE_1
		cp(act_num, PARAM_4)	= id
		moux(act_num, 0)		= point_x
		mouy(act_num, 0)		= point_y
		moux(act_num, 1)		= point_x
		mouy(act_num, 1)		= point_y
	} else {
		if cp(act_num, PARAM_4) == id {
			cp(act_num, PARAM_1)	= SMART_ANALOG_RE_1
			cp(act_num, PARAM_4)	= id
			moux(act_num, 0)		= circle_x + (cos(rad) * circle_half_width)
			mouy(act_num, 0)		= circle_y + (sin(rad) * circle_half_width)
			moux(act_num, 1)		= point_x
			mouy(act_num, 1)		= point_y
		}
	}

	if (cp(act_num, PARAM_1) == SMART_ANALOG_RE_1) && (cp(act_num, PARAM_4)	== id) {
		rep_break				= TRUE
		if rad < 0.0 : rad += M_PI * 2
		deg						= int(rad * 180 / M_PI)
		cp(act_num, PARAM_2)	= deg
		cp(act_num, PARAM_3)	= int(RAD_DOUBLE * rad)

		touch_point_x			= abs(circle_x - point_x)
		touch_point_y			= abs(circle_y - point_y)
		touch_distance_all		= (touch_point_x * touch_point_x) + (touch_point_y * touch_point_y)
		touch_distance_all		= int(sqrt(touch_distance_all))

		touch_point_x			= abs(circle_x - moux(act_num, 0))
		touch_point_y			= abs(circle_y - mouy(act_num, 0))
		touch_distance_in		= (touch_point_x * touch_point_x) + (touch_point_y * touch_point_y)
		touch_distance_in		= int(sqrt(touch_distance_in))
	}

	return


;-----------------------------------------------------
#deffunc local func_analog_res int act_num, array result_value

	dim result_value, 9

	touch_id = 0 : mtlist touch_id : tap_key = stat

	touch_flg = FALSE

	if tap_key > 0 {
		dim touch, tap_key
		repeat tap_key
			mtinfo touch, touch_id(cnt)
			if cp(act_num, PARAM_4) == (touch(3) + 10) {
				touch_flg = TRUE
				break
			}
		loop
	}

	if touch_flg == FALSE {
		cp(act_num, PARAM_1)	= SMART_ANALOG_RE_0
		moux(act_num, 0)		= result_circle_x
		mouy(act_num, 0)		= result_circle_y
		touch_distance_in		= 0
		moux(act_num, 1)		= result_circle_x
		mouy(act_num, 1)		= result_circle_y
		touch_distance_all		= 0
		cp(act_num, PARAM_2)	= 0
		cp(act_num, PARAM_3)	= 0
	}

	result_value(0) = cp(act_num, PARAM_1)	; タッチ中フラグ(0:未タッチ, 1:タッチ中)
	result_value(1) = moux(act_num, 0)		; X座標(領域内のみ)
	result_value(2) = mouy(act_num, 0)		; Y座標(領域内のみ)
	result_value(3) = touch_distance_in		; 中心点座標からドット距離(領域内のみ)
	result_value(4) = moux(act_num, 1)		; X座標(領域外も含む)
	result_value(5) = mouy(act_num, 1)		; Y座標(領域外も含む)
	result_value(6) = touch_distance_all	; 中心点座標からドット距離(領域外も含む)
	result_value(7) = cp(act_num, PARAM_2)	; 角度(360)
	result_value(8) = cp(act_num, PARAM_3)	; ラジアン

	return


;-----------------------------------------------------
; smart_reset
;
; アクションをリセット
;
; act_num						: アクションをリセットするアクション番号
;
;=====================================================
;
;-----------------------------------------------------
#deffunc _smart_reset int act_num

	repeat 4
		tv(act_num, cnt) = 0
		cp(act_num, cnt) = 0
	loop

	return


;-----------------------------------------------------
#deffunc local func_dgetkey var re_v, int keycode, int repeat_flg

	re_v	= SMART_TAP_RE_0
	key		= FALSE

	getkey key, keycode

	switch repeat_flg
	case SMART_GETKEY_REPEAT_MODE_0
		re_v = (key != dkey(keycode)) && (key != FALSE)
		swbreak
	case SMART_GETKEY_REPEAT_MODE_1
		if key == TRUE {
			re_v = SMART_TAP_RE_1
		}
		swbreak
	case SMART_GETKEY_REPEAT_MODE_2
		if dkey(keycode) == FALSE {
			if key == TRUE {
				re_v = SMART_TAP_RE_1
			}
		} else {
			if dkey(keycode) == TRUE {
				if key == FALSE {
					re_v = SMART_TAP_RE_2
				} else {
					if key == TRUE {
						re_v = SMART_TAP_RE_1
					}
				}
			}
		}
		swbreak
	swend

	dkey(keycode) = key

	return


#global

;-----------------------------------------------------
#endif
