var _indicators
var _window = global.window

if _window != undefined {
	_window.draw(0, 0)
	_indicators = _window.indicators("")
	
	var _item_focus = global.item_focus
	
	if _item_focus != undefined {
		_indicators = _item_focus.indicators(_indicators)
	}
} else {
	draw_text(16, 16, $"X: {cursor_x}\nY: {cursor_y}\n{round((1 / zoom) * 100)}%")
	_indicators = "[Space] Menu\n[Shift] Unsnap Cursor\n[C] Reset View"
}

var _text_y = window_height - 16
var _current_def = global.current_def

if _current_def != undefined {
	var _image = undefined

	if is_instanceof(_current_def, ThingDef) {
		_image = _current_def.image
	} else if is_instanceof(_current_def, PropDef) {
		_image = _current_def.material.image
	} else if is_instanceof(_current_def, PolygonDef) {
		_image = _current_def.material.image
	}
	
	if is_instanceof(_image, Image) {
		draw_sprite_stretched(_image.sprite, 0, window_width - 80, window_height - 80, 64, 64)
	} else {
		draw_set_halign(fa_right)
		draw_text(window_width - 16, _text_y, _current_def.name)
		draw_set_halign(fa_left)
	}
	
	if _window == undefined {
		_indicators += "\n[LMB] Place"
	}
}

draw_set_valign(fa_bottom)
draw_text_color(16, _text_y, _indicators, c_white, c_white, c_white, c_white, 0.5)
draw_set_valign(fa_top)