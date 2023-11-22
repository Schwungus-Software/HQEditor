var _window = global.window

if _window != undefined {
	_window.draw(0, 0)
	
	var _indicators = _window.indicators("")
	var _item_focus = global.item_focus
	
	if _item_focus != undefined {
		_indicators = _item_focus.indicators(_indicators)
	}
	
	draw_set_valign(fa_bottom)
	draw_text_color(16, window_get_height() - 16, _indicators, c_white, c_white, c_white, c_white, 0.5)
	draw_set_valign(fa_top)
}